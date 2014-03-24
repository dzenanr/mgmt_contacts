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
  
  ContactsApp app; 

  ContactForm(this.app) {
    contacts = app.model.contacts;
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
  
  setFields(Contact contact) {
    if (contact == null) {
      txtEmail.value = '';
      txtLastName.value = '';
      txtFirstName.value = '';
      txtTelephone.value = '';
      txtDescription.value = ''; 
    } else {
      txtEmail.value = contact.email;
      txtLastName.value = contact.lastName;
      txtFirstName.value = contact.firstName;
      txtTelephone.value = contact.telephone;
      txtDescription.value = contact.description;
    }
  }
  
  saveContact(Event e) {
    var email = txtEmail.value;
    var contact = contacts.singleWhereAttributeId('email', email);
    if (contact == null) {
      if (app.currentContact == null) {
        contact = new Contact(contacts.concept);
        contact.email = txtEmail.value;
        contact.lastName = txtLastName.value;
        contact.firstName = txtFirstName.value;
        contact.telephone = txtTelephone.value;
        contact.description = txtDescription.value;
        contacts.add(contact);
      }
    } else if (app.currentContact != null) {
      contact.lastName = txtLastName.value;
      contact.firstName = txtFirstName.value;
      contact.telephone = txtTelephone.value;
      contact.description = txtDescription.value;
    } 
    app.save();
  }
  
  cancelAction(Event e) {
    txtEmail.focus();
  }
}