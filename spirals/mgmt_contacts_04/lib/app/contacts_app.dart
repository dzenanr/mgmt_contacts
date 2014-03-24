part of mgmt_contacts_app;

class ContactsApp {
  ContactsEntries model;
  Contact _currentContact;
  
  ContactTable contactTable;
  ContactForm contactForm;
  
  ContactsApp(MgmtModels domain) {
    model = domain.getModelEntries("Contacts"); 
    _load(model);
    contactTable = new ContactTable(this);
    contactForm = new ContactForm(this);
  }
  
  Contact get currentContact => _currentContact;
  set currentContact(Contact contact) {
    _currentContact = contact;
    contactForm.setFields(contact);
  } 
  
  _load(ContactsEntries model) {
    String json = window.localStorage['mgmt_contacts_data'];
    if (json != null && model.isEmpty) {
      model.fromJson(json);
    }
  }
  
  save() {
    window.localStorage['mgmt_contacts_data'] = model.toJson();
  }
}

