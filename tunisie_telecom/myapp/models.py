
from django.db import models
from django.contrib.auth.models import AbstractUser


class admin(AbstractUser):
    is_confirmed = models.BooleanField(default=False)


class Vente(models.Model):
    date = models.DateField()
    produit = models.CharField(max_length=100)
    quantite = models.IntegerField()
    
    class Meta:
        db_table = 'ventes'

        



class Objectif(models.Model):
    
    date = models.DateField()
    categorie = models.CharField(max_length=100)
    objectif_quantite = models.IntegerField()

    class Meta:
        
        db_table = 'objectif'
    


   
        

class Resultat(models.Model):
    Date_mensuel = models.DateField()
    Categorie = models.CharField(max_length=100)
    Somme_Quantite_Vendue = models.IntegerField()
    Objectif_Quantite = models.IntegerField()
    Taux = models.DecimalField(max_digits=5, decimal_places=2)

    class Meta:
        db_table = 'resultat'



