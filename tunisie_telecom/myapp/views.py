
import pandas as pd
import mysql.connector
from .forms import UserRegistrationForm, AdminRegistrationForm
from django.shortcuts import render, redirect
from django.db import IntegrityError
from .forms import UploadFileForm, ObjectifForm
from .models import Objectif, Resultat, Vente
from .utils import generate_results
from django.db import connection
from django.db.utils import ProgrammingError, OperationalError
import calendar
from datetime import datetime
from django.contrib.auth import logout
from django.contrib.admin.views.decorators import staff_member_required
from django.contrib.auth.decorators import user_passes_test
from django.shortcuts import get_object_or_404, redirect
from .models import admin
from django.contrib.auth import authenticate, login
from django.contrib.auth.decorators import login_required
from django.contrib.auth.forms import AuthenticationForm


def is_admin(user):
    return user.is_staff

@user_passes_test(is_admin)
def view_users(request):
    users = admin.objects.filter(is_confirmed=True)
    confirmed = admin.objects.filter(is_confirmed=False)
    return render(request, 'view_users.html', {'users': users, 'confirmed': confirmed})





@user_passes_test(is_admin)
def confirm_user(request, user_id):
    user = get_object_or_404(admin, id=user_id)
    user.is_confirmed = True
    user.save()
    return redirect('view_users')

@user_passes_test(is_admin)
def reject_user(request, user_id):
    user = get_object_or_404(admin, id=user_id)
    user.delete()
    return redirect('view_users')

@user_passes_test(is_admin)
def delete_user(request, user_id):
    user = get_object_or_404(admin, id=user_id)
    if user.is_staff:
        user.delete()
        return redirect('home')
    user.delete()
    return redirect('view_users')



    




def login_view(request):
    if request.method == 'POST':
        form = AuthenticationForm(data=request.POST)
        if form.is_valid():
            username = form.cleaned_data.get('username')
            password = form.cleaned_data.get('password')
            user = authenticate(request, username=username, password=password)
            
            if user is not None:
                
                if getattr(user, 'is_confirmed', False): 
                    login(request, user)
                    if user.is_staff:
                        return redirect('data_page')
                    else:
                        return redirect('data_page') 
                else:
                    form.add_error(None, 'Votre compte n\'est pas encore été confirmé.')
        else:
            form.add_error(None, 'Identification incorrecte.')
    else:
        form = AuthenticationForm()

    return render(request, 'home.html', {'form': form})




@login_required
def logout_view(request):
    logout(request)
    return redirect('home')








def admin_registration(request):
    if admin.objects.filter(is_staff=True).exists():
        return redirect('error_page')
    
    if request.method == 'POST':
        form = AdminRegistrationForm(request.POST)
        if form.is_valid():
            try:
                user = form.save()  
                login(request, user)  
                return redirect('data_page')
            except IntegrityError:
                form.add_error('email', 'This email address is already in use.')
    else:
        form = AdminRegistrationForm()
    
    return render(request, 'admin_registration.html', {'form': form})


def error_page(request):
    error_message = "Un administrateur existe déjà."
    return render(request, 'error_page.html', {'error_message': error_message})








def user_registration(request):
    if request.method == 'POST':
        form = UserRegistrationForm(request.POST)
        if form.is_valid():
            user = form.save(commit=False)
            user.is_confirmed = False  
            user.save()
            
            return redirect('waiting_for_confirmation')  
    else:
        form = UserRegistrationForm()
    return render(request, 'user_registration.html', {'form': form})



def waiting_for_confirmation(request):
    return render(request, 'waiting_for_confirmation.html')











def edit_objectif(request, objectif_id):
    objectif = get_object_or_404(Objectif, pk=objectif_id)
    if request.method == 'POST':
        form = ObjectifForm(request.POST, instance=objectif)
        if form.is_valid():
            old_objectif = Objectif.objects.get(pk=objectif_id)
            objectif = form.save()
            update_results(objectif, old_objectif)
            return redirect('view_objectives')
    else:
        form = ObjectifForm(instance=objectif)
    
    return render(request, 'objectif_form.html', {'form': form})

def update_results(new_objectif, old_objectif):
    old_results = Resultat.objects.filter(Date_mensuel=old_objectif.date, Categorie=old_objectif.categorie)

    for old_result in old_results:
        if old_result.Objectif_Quantite == old_objectif.objectif_quantite:
            old_result.Objectif_Quantite = new_objectif.objectif_quantite
            old_result.Taux = calculate_rate(old_result.Somme_Quantite_Vendue, new_objectif.objectif_quantite)
            old_result.Categorie = new_objectif.categorie 
            old_result.save()
        else:
            old_result.delete()
            new_result = Resultat(
                Date_mensuel=new_objectif.date,
                Categorie=new_objectif.categorie,
                Somme_Quantite_Vendue=old_result.Somme_Quantite_Vendue,
                Objectif_Quantite=new_objectif.objectif_quantite,
                Taux=calculate_rate(old_result.Somme_Quantite_Vendue, new_objectif.objectif_quantite)
            )
            new_result.save()

def calculate_rate(somme_quantite_vendue, objectif_quantite):
    if objectif_quantite == 0:
        return 0
    return (somme_quantite_vendue / objectif_quantite) * 100




@staff_member_required
def delete_objectif(request, objectif_id):
    objectif = get_object_or_404(Objectif, id=objectif_id)
    
   
    Resultat.objects.filter(Date_mensuel=objectif.date, Categorie=objectif.categorie, Objectif_Quantite=objectif.objectif_quantite).delete()
    
    objectif.delete()
    
    return redirect('view_objectives')



@login_required
def view_objectives(request):
    objectifs = Objectif.objects.all()
 
    resultats = Resultat.objects.all()

    context = {
        'objectifs': objectifs,
        'resultats': resultats,  
    }
    return render(request, 'view_objectives.html', context)
MONTH_M= {
    1: 'janvier', 2: 'février', 3: 'mars', 4: 'avril', 5: 'mai', 6: 'juin',
    7: 'juillet', 8: 'août', 9: 'septembre', 10: 'octobre', 11: 'novembre', 12: 'décembre'
}

MONTH_NAMES = {
    1: 'janv', 2: 'févr', 3: 'mars', 4: 'avr', 5: 'mai', 6: 'juin',
    7: 'juil', 8: 'août', 9: 'sept', 10: 'oct', 11: 'nov', 12: 'déc'
}

def delete_month_content(request, month):
   
    month_start = datetime.strptime(month, '%Y-%m')
    month_end = month_start.replace(day=calendar.monthrange(month_start.year, month_start.month)[1])
    
    
    Vente.objects.filter(date__range=[month_start, month_end]).delete()
    
    
    if not Vente.objects.exists():
        with connection.cursor() as cursor:
            cursor.execute("DROP TABLE IF EXISTS ventes")
    
    return redirect('data_page')
@login_required
def data_page(request):
    try:
        
        ventes = Vente.objects.all()

        ventes_by_month = {}
        
        for vente in ventes:
            month = vente.date.strftime('%Y-%m')
            if month not in ventes_by_month:
                ventes_by_month[month] = []
            ventes_by_month[month].append(vente)
        
        data_by_month = []
        for month, ventes in ventes_by_month.items():
            dates = sorted(set(vente.date.strftime('%Y-%m-%d') for vente in ventes))
            produits = {}
            
            for vente in ventes:
                produit = vente.produit
                if produit not in produits:
                    produits[produit] = [None] * len(dates)
                
                date_index = dates.index(vente.date.strftime('%Y-%m-%d'))
                produits[produit][date_index] = vente.quantite
            
            
            year, month_num = month.split('-')
            month_name = MONTH_NAMES[int(month_num)]
            short_month_name = MONTH_M[int(month_num)]

            data_by_month.append({
                'month': month,
                'month_name': f"{month_name} {year}",
                'short_month_name': f"{short_month_name} {year}",
                'dates': dates,
                'produits': produits
            })

        context = {
            'data_by_month': data_by_month
        }
        return render(request, 'data.html', context)

    except OperationalError as e:
        if "1146" in str(e):  
            error_message = "To see the data you need to download excel information file."
            return render(request, 'error.html', {'error_message': error_message})
        else:
            raise e  

    except ProgrammingError as e:
        if "1146" in str(e):  
            error_message = "To see the data you need to download excel information file."
            return render(request, 'error.html', {'error_message': error_message})
        else:
            raise e  
       




@login_required
def dashboard(request):
    
    tables = connection.introspection.table_names()
    if 'ventes' not in tables:
        error_message = "To see the dashboard you need to download excel information file."
        return render(request, 'error.html', {'error_message': error_message})
    resultats = Resultat.objects.all()

    data = []
    for resultat in resultats:
        data.append({
            'Date_mensuel': resultat.Date_mensuel.strftime('%Y-%m-%d'),
            'Categorie': resultat.Categorie,
            'Somme_Quantite_Vendue': resultat.Somme_Quantite_Vendue,
            'Objectif_Quantite': resultat.Objectif_Quantite,
            'Taux': float(resultat.Taux) if resultat.Taux is not None else None
        })

    context = {
        'data': data
    }

    return render(request, 'dashboard.html', context)


@login_required
def objectif_form(request):
   
    tables = connection.introspection.table_names()
    if 'ventes' not in tables:
        error_message = "Pour définir des objectifs, vous devez télécharger un fichier d'informations Excel."
        return render(request, 'error.html', {'error_message': error_message})

    if request.method == 'POST':
        form = ObjectifForm(request.POST)
        if form.is_valid():
            mois = form.cleaned_data['mois']
            categorie = form.cleaned_data['categorie']
            objectif_quantite = form.cleaned_data['objectif_quantite']

            existing_objectif = Objectif.objects.filter(date=mois, categorie=categorie).first()
            if existing_objectif:
              
                existing_objectif.objectif_quantite += objectif_quantite
                existing_objectif.save()
                
                update_results(existing_objectif, existing_objectif)
            else:
                
                objectif = Objectif(date=mois, categorie=categorie, objectif_quantite=objectif_quantite)
                objectif.save()
               
                generate_results()

            return redirect('success')
    else:
        form = ObjectifForm()
    return render(request, 'objectif_form.html', {'form': form})
       
def handle_uploaded_file(file):
    df = pd.read_excel(file, header=None)

    def convert_date(date_str):
        date_obj = pd.to_datetime(date_str, errors='coerce')
        if pd.isnull(date_obj):
            return None
        return date_obj.strftime('%Y-%m-%d')

    conn = mysql.connector.connect(
        host='localhost',
        user='root',
        password='',
        database='tunisie_telecom'
    )
    cursor = conn.cursor()

    cursor.execute('''
    CREATE TABLE IF NOT EXISTS ventes (
        id INT AUTO_INCREMENT PRIMARY KEY,
        date DATE,
        produit VARCHAR(255),
        quantite INT
    )
    ''')

    def process_section(df_section):
        headers = df_section.iloc[0]
        df_section = df_section[1:]
        df_section.columns = headers

        for i, ligne in df_section.iterrows():
            produit = ligne[headers[0]]

            if pd.isna(produit) or produit == '':
                continue

            for col in headers[1:]:
                date = convert_date(col)
                quantite = ligne[col]

                if pd.notna(quantite) and date is not None:
                    cursor.execute('''
                    INSERT INTO ventes (date, produit, quantite) VALUES (%s, %s, %s)
                    ''', (date, produit, quantite))

    section_start = 0
    for i in range(len(df)):
        if df.iloc[i].isnull().all():
            process_section(df.iloc[section_start:i])
            section_start = i + 1
    process_section(df.iloc[section_start:])

    conn.commit()
    conn.close()
@login_required
def upload_file(request):
    if request.method == 'POST':
        form = UploadFileForm(request.POST, request.FILES)
        if form.is_valid():
            handle_uploaded_file(request.FILES['file'])
            return redirect('objectif_form')
    else:
        form = UploadFileForm()
    return render(request, 'upload.html', {'form': form})

def success(request):
    return render(request, 'success.html')


def home(request):
    return render(request, 'home.html')









