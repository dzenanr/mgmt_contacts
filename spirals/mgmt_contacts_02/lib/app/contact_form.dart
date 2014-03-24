part of mgmt_contacts_app;

class ContactForm {
  Contacts contacts;
  
  InputElement txtEmail;
  InputElement txtLastName;
  InputElement txtFirstName;
  InputElement txtTelephone;
  InputElement txtDescription;

  ButtonElement btnSave;
  ButtonElement btnCancel;
  
  ContactTable contactTable;

  ContactForm(this.contactTable) {
    contacts = contactTable.contacts;
    bindElements();
    addEventHandlers();
    txtEmail.focus();
  }
  
  bindElements() {
    txtEmail = querySelector('#txtEmail');
    txtLastName = querySelector('#txtLastName');
    txtFirstName = querySelector('#txtFirstName');
    txtTelephone = querySelector('#txtTelephone');
    txtDescription = querySelector('#txtDescription');

    btnSave = querySelector('#btnSave');
    btnCancel = querySelector('#btnCancel');
  }
  
  addEventHandlers() {
    btnSave.onClick.listen(saveContact);
    btnCancel.onClick.listen(cancelAction);
  }
  
  saveContact(Event e) {
    Contact newContact = new Contact(contacts.concept);
    newContact.email = txtEmail.value;
    newContact.lastName = txtLastName.value;
    newContact.firstName = txtFirstName.value;
    newContact.telephone = txtTelephone.value;
    newContact.description = txtDescription.value;
    var added = contacts.add(newContact);
    //assert(added);
    contactTable.app.save();
    contactTable.display();
  }
  
  cancelAction(Event e) {
    txtEmail.focus();
  }
}