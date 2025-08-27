// ignore_for_file: prefer_single_quotes, require_trailing_commas

const Map<String, dynamic> langMap = {
  "kyc_module": {
    "appBarTitle": "KYC",
    "common": {
      "initializing": "Initialisation...",
      "an_error_occur": "Une erreur est survenue: {{message}}",
      "insufficient_funds": "Solde insuffisant",
      "all": "Tout",
      "buy": "Payer",
      "cancel": "Annuler",
      "validate": "Valider",
      "country": "Pays",
      "next": "Suivant",
      "start": "Démarrer",
      "upload": "Téléverser",
      "try_again": "Re-essayez",
			"all_fields_required": "Tous les champs sont obligatoire",
			"field_required": "Le champ {{field}} est obligatoire"
    },
    "image_service": {
			"choose_camera": "Camera",
			"choose_gallery": "Gallerie"
    },
		"status_screen": {
			"title": "Statut de la vérification KYC",
			"success_title": "Succès",
			"success_message": "Vous pouvez dès à présent utiliser l'application et introduire vos demandes de paiement.",
			"success_button_text": "Retour à l’accueil",
			"failed_title": "Échec",
			"failed_message": "Nous constatons des incohérences dans les informations fournies: {{message}}",
			"failed_button_text": "Introduire une nouvelle demande",
			"pending_title": "En attente",
			"pending_message": "Vos documents sont en cours de vérification. Vous pouvez annuler cette demande si vous le souhaitez.",
			"pending_button_text": "Annuler la demande",
			"unknown_title": "Statut Inconnu",
			"unknown_message": "Une erreur est survenue. Veuillez contacter le support.",
			"unknown_button_text": "Retour",
			"kyc_not_submitted": "Aucune demande de KYC soumise.",
			"start_kyc_verification" : "Commencer la vérification KYC"
		},
    "stepper": {
      "step1": "Données perso.",
      "step2": "Résidence",
      "step3": "Carte Identité",
      "step4": "Infos Fiscales",
      "step5": "Selfie",
      "step6": "Selfie+ ID Card"
    },
    "step1": {
      "title": "Données personnelles",
      "description":
          "S'il vous plait, entrer vos informations personelles telles qu'elles figurent sur votre pièce d'identité nationale.",
      "surname": "Prénom",
      "name": "Nom",
      "birthdate": "Date de naissance",
      "gender": "Genre",
      "man": "Homme",
      "woman": "Femme",
      "others": "Autres"
    },
    "step2": {
      "title": "Adrèsse",
      "description": "Nous avons besion de cette information pour les documents officiels",
      "street": "Rue",
      "city": "Ville",
      "postal_code": "Code postal"
    },
    "step3": {
      "type_page_title": "Type de pièce d'identité",
      "type_page_description": "S'il vous plait choisissez votre méthode",
      "upload_front_page_title": "Carte Identité (Recto)",
      "upload_front_page_description": "Charger une image lisible du recto de votre pièce",
      "upload_back_page_title": "Carte Identité (Verso)",
      "upload_back_page_description": "Charger une image lisible du verso de votre pièce",
      "nationality": "Nationalité",
      "verification_method": "Méthode de vérification",
      "id_card": "Carte nationale d'identité",
      "passport": "Passport",
      "driving_license": "Permis de conduire",
      "load_image": "Charger votre pièce",
			"consent_not_checked": "Vous devez accepter le consentement",
      "warning":
          "J'accepte par la présente que le document ci-dessus m'appartient et donne volontairement mon consentement à Bantubeat pour l'utiliser comme preuve d'adresse pour KYC à dessein uniquement",
			"pick_recto_page_title": "Pièce d'identité (Recto)",
      "pick_verso_page_description": "Charger une image lissible du verso de votre carte d’identité",
			"pick_verso_page_title": "Pièce d'identité (Verso)",
			"pick_recto_page_description": "Charger une image lisible du recto de votre carte d'identité"
    },
    "step4": {
      "title": "Informations fiscales",
      "description": "Entrer votre numéro d’identification fiscal ou unique selon le pays dans lequel vous êtes",
      "account_type": "Type de compte",
      "account_type_particular": "Particulier",
      "account_type_company": "Entreprise",
      "nui_number": "Numéro d’identification fiscale ou unique/N° national",
      "company_name": "Nom de l'entreprise",
      "company_registration_number": "Numéro d’enregistrement de l’entreprise",
      "company_tva_number": "Numéro de TVA/Numéro d’entreprise",
			"upload_file": "Charger un document officiel"
    },
    "step5": {
      "title": "Selfie",
      "description": "Faite une photo claire en mode selfie de votre visage."
    },
    "step6": {
      "title": "Selfie + ID Card",
      "description":
          "Faite une photo claire en mode selfie de votre visage en tenant votre pièce d'identité."
    }
  }
};
