import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Politique de Confidentialité'),
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Politique de Confidentialité de Koodiarana',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            ),
            SizedBox(height: 16),
            Text(
              '1. Introduction',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Text(
              'Bienvenue sur Koodiarana, une application de mise en relation pour le transport de personnes. La confidentialité de vos données est une priorité pour nous. Cette politique de confidentialité décrit les types de données personnelles que nous collectons, comment nous les utilisons, et les mesures que nous prenons pour garantir leur protection.',
            ),
            SizedBox(height: 16),
            Text(
              '2. Informations collectées',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Text(
              'a. Informations personnelles fournies par l’utilisateur :\n'
              '- Nom complet\n'
              '- Adresse e-mail\n'
              '- Numéro de téléphone\n'
              '- Données de paiement (carte de crédit ou compte bancaire)\n'
              '- Photo de profil\n',
            ),
            Text(
              'b. Informations de localisation :\n'
              '- Localisation en temps réel : Nous collectons les données GPS pour faciliter la correspondance entre les conducteurs et les passagers.\n'
              '- Historique des trajets : Nous conservons les détails des trajets pour des raisons de facturation, d’assistance et d’analyse.\n',
            ),
            Text(
              'c. Informations relatives au véhicule (conducteurs) :\n'
              '- Informations sur le véhicule (marque, modèle, plaque d’immatriculation)\n'
              '- Permis de conduire et documents associés\n',
            ),
            Text(
              'd. Informations de l’appareil :\n'
              '- Modèle d’appareil, système d’exploitation, adresse IP et identifiants de l’appareil\n',
            ),
            SizedBox(height: 16),
            Text(
              '3. Utilisation des informations collectées',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Text(
              'Nous utilisons vos informations pour :\n'
              '- Vous permettre de réserver des trajets et d’utiliser les services de l’application.\n'
              '- Assurer la sécurité des utilisateurs (vérification des conducteurs, suivi en temps réel).\n'
              '- Faciliter les paiements et les remboursements.\n'
              '- Améliorer nos services grâce à l’analyse des données.\n'
              '- Vous envoyer des notifications importantes concernant vos trajets ou notre politique de confidentialité.\n',
            ),
            SizedBox(height: 16),
            Text(
              '4. Partage de vos informations',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Text(
              'Nous ne partageons vos informations personnelles qu’avec les entités suivantes :\n'
              '- Conducteurs et passagers : Pour faciliter les trajets.\n'
              '- Prestataires de services tiers : Pour les paiements et la gestion technique.\n'
              '- Autorités légales : En cas de demande légale obligatoire.\n',
            ),
            SizedBox(height: 16),
            Text(
              '5. Sécurité des données',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Text(
              'Nous mettons en œuvre des mesures de sécurité avancées pour protéger vos données contre tout accès non autorisé, modification, divulgation ou destruction.',
            ),
            SizedBox(height: 16),
            Text(
              '6. Vos droits',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Text(
              'Vous avez le droit de :\n'
              '- Accéder à vos données personnelles.\n'
              '- Modifier ou mettre à jour vos informations.\n'
              '- Supprimer votre compte et vos données.\n'
              '- Refuser l’utilisation de vos données pour des finalités spécifiques.\n',
            ),
            SizedBox(height: 16),
            Text(
              '7. Durée de conservation des données',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Text(
              'Nous conservons vos informations aussi longtemps que nécessaire pour vous fournir nos services.',
            ),
            SizedBox(height: 16),
            Text(
              '8. Modifications de la politique de confidentialité',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Text(
              'Nous nous réservons le droit de modifier cette politique à tout moment. Les modifications seront communiquées via l’application ou par e-mail.',
            ),
            SizedBox(height: 16),
            Text(
              '9. Contact',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Text(
              'Pour toute question, contactez-nous à :\n'
              'Email : contact@koodiarana.com',
            ),
          ],
        ),
      ),
    );
  }
}
