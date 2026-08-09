import pandas as pd
from .models import Resultat, Vente, Objectif

def generate_results():
    print("Début de la génération des résultats...")
    
    # Get data from Django ORM
    ventes_data = Vente.objects.all().values('date', 'produit', 'quantite')
    ventes_df = pd.DataFrame(list(ventes_data))
    
    if ventes_df.empty:
        print("Aucune donnée de vente trouvée")
        return
    
    ventes_df['date'] = pd.to_datetime(ventes_df['date'])
    ventes_df['mois'] = ventes_df['date'].dt.month

    objectifs_data = Objectif.objects.all().values('categorie', 'date', 'objectif_quantite')
    objectifs_df = pd.DataFrame(list(objectifs_data))
    
    if objectifs_df.empty:
        print("Aucun objectif trouvé")
        return
    
    objectifs_df['date'] = pd.to_datetime(objectifs_df['date'])
    objectifs_df['mois'] = objectifs_df['date'].dt.month

    print("Données récupérées avec succès")

    def get_category(product, categories):
        product = product.lower().strip()
        for categorie in categories:
            if categorie.lower() in product:
                return categorie
        return "autre"

    categories = objectifs_df['categorie'].unique()
    ventes_df['categorie'] = ventes_df['produit'].apply(lambda p: get_category(p, categories))

    for _, objectif in objectifs_df.iterrows():
        categorie = objectif['categorie']
        date_limite = objectif['date']
        mois_limite = date_limite.month

        ventes_filtrees = ventes_df[
            (ventes_df['categorie'] == categorie) &
            (ventes_df['date'] <= date_limite) &
            (ventes_df['mois'] == mois_limite)
        ]

        somme_quantite_vendue = ventes_filtrees['quantite'].sum()
        taux = (somme_quantite_vendue / objectif['objectif_quantite']) * 100 if objectif['objectif_quantite'] else None

        resultat_existant = Resultat.objects.filter(
            Date_mensuel=date_limite,
            Categorie=categorie
        ).first()

        if resultat_existant:
            resultat_existant.Somme_Quantite_Vendue = somme_quantite_vendue
            resultat_existant.Objectif_Quantite = objectif['objectif_quantite']
            resultat_existant.Taux = taux
            resultat_existant.save()
            print(f"Résultat mis à jour pour {categorie} le {date_limite}...")
        else:
            resultat = Resultat(
                Date_mensuel=date_limite,
                Categorie=categorie,
                Somme_Quantite_Vendue=somme_quantite_vendue,
                Objectif_Quantite=objectif['objectif_quantite'],
                Taux=taux
            )
            resultat.save()
            print(f"Nouveau résultat créé pour {categorie} le {date_limite}...")

    print("Résultats générés et enregistrés avec succès")
