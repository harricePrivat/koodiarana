import 'package:flutter/material.dart';

class LegalNoticeScreen extends StatelessWidget {
  const LegalNoticeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mention Légale'),
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Mention Légale de Koodiarana',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            ),
            SizedBox(height: 16),
            Text(
              '1. Éditeur du site',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Text(
              'L’application Koodiarana est éditée par :\n'
              'Nom de l’entreprise : Koodiarana Inc.\n'
              'Adresse : 123, Rue de l’Entreprise, Ville, Pays\n'
              'E-mail : contact@koodiarana.com\n'
              'Téléphone : +33 1 23 45 67 89\n',
            ),
            SizedBox(height: 16),
            Text(
              '2. Hébergement',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Text(
              'Le site et l’application sont hébergés par :\n'
              'Nom de l’hébergeur : Hébergeur XYZ\n'
              'Adresse : 456, Rue de l’Hébergement, Ville, Pays\n'
              'E-mail : support@hebergeurxyz.com\n'
              'Téléphone : +33 1 98 76 54 32\n',
            ),
            SizedBox(height: 16),
            Text(
              '3. Propriété intellectuelle',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Text(
              'L’intégralité du contenu de l’application Koodiarana, y compris les textes, images, graphismes, logos, et icônes, est protégée par les lois en vigueur en matière de propriété intellectuelle. Toute reproduction, distribution ou utilisation sans autorisation est strictement interdite.\n',
            ),
            SizedBox(height: 16),
            Text(
              '4. Responsabilité',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Text(
              'Koodiarana Inc. décline toute responsabilité pour les dommages directs ou indirects pouvant survenir lors de l’utilisation de l’application. Nous ne garantissons pas la disponibilité continue du service.\n',
            ),
            SizedBox(height: 16),
            Text(
              '5. Protection des données personnelles',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Text(
              'Les informations personnelles collectées sur l’application Koodiarana sont traitées conformément à notre politique de confidentialité et aux réglementations en vigueur, telles que le RGPD. Vous disposez d’un droit d’accès, de rectification et de suppression de vos données personnelles. Pour plus d’informations, veuillez consulter notre politique de confidentialité.\n',
            ),
            SizedBox(height: 16),
            Text(
              '6. Liens externes',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Text(
              'Koodiarana peut contenir des liens vers des sites externes. Nous ne sommes pas responsables du contenu de ces sites, ni de la protection de vos données lorsque vous visitez des sites tiers.\n',
            ),
            SizedBox(height: 16),
            Text(
              '7. Droit applicable',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Text(
              'La présente mention légale est régie par le droit en vigueur dans le pays de résidence de Koodiarana Inc. En cas de litige, les tribunaux compétents seront ceux du siège de Koodiarana Inc.\n',
            ),
            SizedBox(height: 16),
            Text(
              '8. Contact',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Text(
              'Pour toute question concernant cette mention légale, vous pouvez nous contacter à l’adresse suivante :\n'
              'Email : contact@koodiarana.com\n'
              'Téléphone : +33 1 23 45 67 89\n',
            ),
          ],
        ),
      ),
    );
  }
}
