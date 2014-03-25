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
    txtTelephone.onKeyDown.listen(enforcePhoneMask);
    btnSave.onClick.listen(saveContact);
    btnCancel.onClick.listen(cancelAction);
  }
  
  /**
   * Accept only integers and add dashes automatically
   */
  enforcePhoneMask(KeyboardEvent e) {
    int keyCode = e.keyCode;  
    if (keyCode == KeyCode.BACKSPACE) {
      return;
    } else if (keyCode == KeyCode.TAB || keyCode == KeyCode.ENTER) {
      clearPhoneIfInvalid();
    } else if (!numericCodes.keys.contains(keyCode)) {
      e.preventDefault();
    } else if (txtTelephone.value.length == 2 || txtTelephone.value.length == 6) {
      txtTelephone.value = txtTelephone.value + numericCodes[keyCode] + '-';
      e.preventDefault();
    } else if (txtTelephone.value.length == 3 || txtTelephone.value.length == 7) {
      txtTelephone.value = txtTelephone.value + '-' + numericCodes[keyCode];
      e.preventDefault();
    }
  }
  
  clearPhoneIfInvalid() => 
      txtTelephone.value.length != 12 ? txtTelephone.value = '' : null;

  Map<int, String> get numericCodes {
    Map<int, String> numericCodes = new Map<int,String>();
    numericCodes[KeyCode.ZERO] = '0';
    numericCodes[KeyCode.ONE] = '1';
    numericCodes[KeyCode.TWO] = '2';
    numericCodes[KeyCode.THREE] = '3';
    numericCodes[KeyCode.FOUR] = '4';
    numericCodes[KeyCode.FIVE] = '5';
    numericCodes[KeyCode.SIX] = '6';
    numericCodes[KeyCode.SEVEN] = '7';
    numericCodes[KeyCode.EIGHT] = '8';
    numericCodes[KeyCode.NINE] = '9';
    return numericCodes;
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