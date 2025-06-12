
from .models import Objectif, Vente
from calendar import monthrange
from .models import admin  
from django import forms
from django.contrib.auth.forms import UserCreationForm




class AdminRegistrationForm(UserCreationForm):
    class Meta:
        model = admin
        fields = ['username', 'email', 'password1', 'password2']

    def clean_email(self):
        email = self.cleaned_data.get('email')
        if admin.objects.filter(email=email).exists():
            raise forms.ValidationError('This email address is already in use.')
        return email

    def save(self, commit=True):
        user = super().save(commit=False)
        user.is_staff = True 
        user.is_confirmed = True  
        if commit:
            user.save()
        return user

class UserRegistrationForm(UserCreationForm):
    class Meta:
        model = admin
        fields = ['username', 'email', 'password1', 'password2']

    def clean_email(self):
        email = self.cleaned_data.get('email')
        if admin.objects.filter(email=email).exists():
            raise forms.ValidationError('This email address is already in use.')
        return email






class UploadFileForm(forms.Form):
    file = forms.FileField()

   

class ObjectifForm(forms.ModelForm):
    mois = forms.DateField(
        widget=forms.TextInput(attrs={'type': 'month'}),
        label="Mois",
        input_formats=['%Y-%m']
    )
    
    categorie = forms.ChoiceField(choices=[])

    class Meta:
        model = Objectif
        fields = ['mois', 'categorie', 'objectif_quantite']

    def __init__(self, *args, **kwargs):
        super(ObjectifForm, self).__init__(*args, **kwargs)
        self.fields['categorie'].choices = self.get_categories()
        if self.instance and self.instance.pk:
            self.fields['mois'].initial = self.instance.date.strftime('%Y-%m')

    def clean_mois(self):
        mois = self.cleaned_data['mois']
        last_day_of_month = monthrange(mois.year, mois.month)[1]
        return mois.replace(day=last_day_of_month)
    
    def clean_categorie(self):
        categorie = self.cleaned_data['categorie']
        if categorie == '-------Veuillez choisir-------':
            raise forms.ValidationError("Veuillez choisir une catégorie valide.")
        return categorie

    def get_categories(self):
        categories = [('-------Veuillez choisir-------', '-------Veuillez choisir-------')]  
        existing_categories = set()
        for vente in Vente.objects.all():
            product_name = vente.produit.lower().strip()
            first_word = product_name.split()[0]
            if first_word not in existing_categories:
                existing_categories.add(first_word)
                categories.append((first_word, first_word.capitalize()))
        return categories