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
      "title": "Payment Account",
      "description":
          "Please choose and enter the details of your payment account to which you wish to receive your payments",
      "account_type": "Account type",
      "mobile_operator_name": "Mobile operator name",
      "account_number": "Account number",
			"confirm_account_number": "Confirm account number",
			"bank_name": "Bank name",
			"swift_code": "Swift Code",
      "account_holder": "Account holder",
      "load_bank_docs": "Upload a bank document/card",
			"mobile_payment": "Mobile Payment",
			"mobile_payment_way": "Instantly",
			"bank_account": "Bank Account",
			"bank_account_way": "Bank transfer",
			"add_payment_acconut": "Add a payment account",
			"bad_account_number_confirmation": "Bad account number confirmation"
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