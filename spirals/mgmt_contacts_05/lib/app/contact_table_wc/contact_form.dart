part of contact_table_wc;

class ContactForm {
  Contacts contacts;
  
  ContactTableWc wc;
  InputElement txtEmail;
  InputElement txtLastName;
  InputElement txtFirstName;
  InputElement txtTelephone;
  InputElement txtDescription;
  ButtonElement btnSave;
  ButtonElement btnCancel;

  ContactForm(this.wc) {
    contacts = wc.model.contacts;
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
      if (wc.currentContact == null) {
        contact = new Contact(contacts.concept);
        contact.email = txtEmail.value;
        contact.lastName = txtLastName.value;
        contact.firstName = txtFirstName.value;
        contact.telephone = txtTelephone.value;
        contact.description = txtDescription.value;
        contacts.add(contact);
      }
    } else if (wc.currentContact != null) {
      contact.lastName = txtLastName.value;
      contact.firstName = txtFirstName.value;
      contact.telephone = txtTelephone.value;
      contact.description = txtDescription.value;
    } 
    wc.save();
  }
  
  cancelAction(Event e) {
    txtEmail.focus();
  }
}