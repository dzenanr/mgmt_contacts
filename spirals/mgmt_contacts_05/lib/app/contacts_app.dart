part of mgmt_contacts_app;

class ContactsApp {
  ContactsEntries model;
  
  ContactTableWc contactTableWc;
  
  ContactsApp(MgmtModels domain) {
    model = domain.getModelEntries("Contacts"); 
    _load(model);
    contactTableWc = new ContactTableWc(this);
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

