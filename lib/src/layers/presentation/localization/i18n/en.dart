// ignore_for_file: prefer_single_quotes, require_trailing_commas

const Map<String, dynamic> langMap = {
  "kyc_module": {
    "appBarTitle": "KYC",
		"common": {
      "initializing": "Initializing...",
      "an_error_occur": "An error occurred: {{message}}",
      "insufficient_funds": "Insufficient funds",
      "all": "All",
      "buy": "Buy",
      "cancel": "Cancel",
      "validate": "Validate",
      "country": "Country",
      "next": "Next",
      "start": "Start",
      "upload": "Upload",
      "try_again": "Try again",
			"all_fields_required": "All fields are required",
			"field_required": "The field {{field}} is required"
    },
    "image_service": {
			"choose_camera": "Camera",
			"choose_gallery": "Gallery"
    },
		"status_screen": {
			"title": "KYC Verification Status",
			"success_title": "Success",
			"success_message": "You can now use the app and submit your payment requests.",
			"success_button_text": "Back to Home",
			"failed_title": "Failure",
			"failed_message": "We found inconsistencies in the provided information: {{message}}",
			"failed_button_text": "Submit a new request",
			"pending_title": "Pending",
			"pending_message": "Your documents are being verified. You can cancel this request if you wish.",
			"pending_button_text": "Cancel Request",
			"unknown_title": "Unknown Status",
			"unknown_message": "An error occurred. Please contact support.",
			"unknown_button_text": "Back",
			"kyc_not_submitted": "No KYC request submitted.",
			"start_kyc_verification" : "Start KYC Verification"
		},
    "stepper": {
      "step1": "Personal Data",
      "step2": "Residency",
      "step3": "ID Card",
      "step4": "Payment Account",
      "step5": "Selfie",
      "step6": "Selfie + ID Card"
    },
    "step1": {
      "title": "Personal Data",
      "description":
          "Please enter your personal information as it appears on your national identification document.",
      "surname": "First Name",
      "name": "Last Name",
      "birthdate": "Date of Birth",
      "gender": "Gender",
      "man": "Male",
      "woman": "Female",
      "others": "Others"
    },
    "step2": {
      "title": "Address",
      "description": "We need this information for official documents",
      "street": "Street",
      "city": "City",
      "postal_code": "Postal code"
    },
    "step3": {
      "type_page_title": "ID Document type",
      "type_page_description": "Please choose your method",
      "upload_front_page_title": "ID Card (Front)",
      "upload_front_page_description": "Upload a readable image of the front of your document",
      "upload_back_page_title": "ID Card (Back)",
      "upload_back_page_description": "Upload a readable image of the back of your document",
      "nationality": "Nationality",
      "verification_method": "Verification method",
      "id_card": "National ID Card",
      "passport": "Passport",
      "driving_license": "Driving license",
      "load_image": "Upload your document",
			"consent_not_checked": "You must accept the consent",
      "warning":
          "I hereby accept that the above document belongs to me and voluntarily give my consent to Bantubeat to use it as proof of address for KYC for this purpose only",
			"pick_recto_page_title": "ID Document (Front)",
      "pick_verso_page_description": "Upload a readable image of the back of your ID document",
			"pick_verso_page_title": "ID Document (Back)",
			"pick_recto_page_description": "Upload a readable image of the front of your ID document"
		},
    "step4": {
			"title": "Tax Information",
      "description": "Enter your tax identification number or unique number depending on the country you are in",
      "account_type": "Account Type",
      "account_type_particular": "Individual",
      "account_type_company": "Business",
      "nui_number": "Tax ID or unique number/National ID number",
      "company_name": "Company name",
      "company_registration_number": "Company registration number",
      "company_vat_number": "VAT number/Company number",
      "upload_file": "Upload an official document"
    },
    "step5": {
      "title": "Selfie",
      "description": "Take a clear selfie of your face."
    },
    "step6": {
      "title": "Selfie + ID Card",
      "description":
          "Take a clear selfie of your face while holding your identification document."
    }
  }
};