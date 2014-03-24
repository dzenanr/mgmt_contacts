part of mgmt_contacts_app;

class ContactsApp {
  ContactsEntries model;
  
  ContactsApp(MgmtModels domain) {
    model = domain.getModelEntries("Contacts"); 
    _load(model);
    var contactTable = new ContactTable(this);
    new ContactForm(contactTable);
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

