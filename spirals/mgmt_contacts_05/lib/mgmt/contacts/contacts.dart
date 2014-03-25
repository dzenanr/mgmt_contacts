part of mgmt_contacts; 
 
// lib/mgmt/contacts/contacts.dart 
 
class Contact extends ContactGen { 
 
  Contact(Concept concept) : super(concept); 
 
  Contact.withId(Concept concept, String email) : 
    super.withId(concept, email); 
 
  // added after code gen - begin 
  
  static const String REGEX_PHONE = "[0-9]{3}-[0-9]{3}-[0-9]{4}";
  
  set telephone(String phone) {
    var regex = new RegExp(REGEX_PHONE);
    if (regex.hasMatch(phone)) {
      super.telephone = phone;
    }
  } 
  
  /**
   * Compares two contacts based on the last and first names.
   * If the result is less than 0 then the first entity is less than the second,
   * if it is equal to 0 they are equal and
   * if the result is greater than 0 then the first is greater than the second.
   */
  int compareTo(Contact other) {
    var c = lastName.compareTo(other.lastName);
    if (c == 0) {
      return firstName.compareTo(other.firstName);
    }
    return c;
  }
  
  int compareEmail(Contact other) {
    return email.compareTo(other.email);
  }
 
  // added after code gen - end 
 
} 
 
class Contacts extends ContactsGen { 
 
  Contacts(Concept concept) : super(concept); 
 
  // added after code gen - begin 
  
  bool preAdd(Contact contact) {
    bool validation = super.preAdd(contact);
    if (validation) {
      validation = contact.email.trim() != '';
      if (!validation) {
        var error = new ValidationError('pre');
        error.message =
            '${concept.codePlural}.preAdd rejects the "${contact.email}" '
            'email that is empty.';
        errors.add(error);
      }
    }
    return validation;
  }
  
  // added after code gen - end 
 
} 
 
