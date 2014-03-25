part of contact_table_wc;

class ContactTable {
  Contacts contacts;
  
  ContactTableWc wc; 
  TableElement contactTable;
  Element thEdit;
  Element thEmail;
  Element thLastName;
  ButtonElement btnRemoveContact;
  ButtonElement btnDoNotRemoveContact;

  ContactTable(this.wc) {
    contacts = wc.model.contacts;
    bindElements();
    addEventHandlers();
    contacts.sort();
    display();
  }
  
  bindElements() {
    contactTable = querySelector('#contact-table');
    thEdit = querySelector('#thEdit');
    thEmail = querySelector('#thEmail');
    thLastName = querySelector('#thLastName');
    btnRemoveContact = querySelector('#btnOk');
    btnRemoveContact.style.display = 'none';
    btnDoNotRemoveContact = querySelector('#btnNok');
    btnDoNotRemoveContact.style.display = 'none';
  }
  
  addEventHandlers() {
    thEdit.onClick.listen(removeSelection);
    thEmail.onClick.listen(changeSort);
    thLastName.onClick.listen(changeSort);
    btnRemoveContact.onClick.listen(removeContactAfterConfirmation);
    btnDoNotRemoveContact.onClick.listen(doNotRemoveContact);
  }
  
  display() {
    for (Contact contact in contacts) {
      addRow(contact);
    }  
  }
  
  addRow(Contact contact) {
    TableRowElement row = new Element.tr();
    
    TableCellElement tdEdit = new Element.td();
    var imgEdit = new InputElement();
    imgEdit.type = 'image';
    imgEdit.src = 'img/edit.png';
    imgEdit.title = 'Edit this contact';
    imgEdit.value = contact.email; 
    imgEdit.onClick.listen(editContact);
    tdEdit.nodes.add(imgEdit);
    row.nodes.add(tdEdit);
    
    TableCellElement tdRemove = new Element.td();
    var imgRemove = new InputElement();
    imgRemove.type = 'image';
    imgRemove.src = 'img/remove.png';
    imgRemove.title = 'Remove this contact';
    imgRemove.value = contact.email; 
    imgRemove.onClick.listen(toRemoveContact);
    tdRemove.nodes.add(imgRemove);
    row.nodes.add(tdRemove);
    
    TableCellElement tdEmail = new Element.td();
    tdEmail.text = contact.email;
    row.nodes.add(tdEmail);
          
    TableCellElement tdLastName = new Element.td();
    tdLastName.text = contact.lastName;
    row.nodes.add(tdLastName);
    
    TableCellElement tdFirstName = new Element.td();
    tdFirstName.text = contact.firstName;
    row.nodes.add(tdFirstName);
     
    row.id = contact.email;
    contactTable.nodes.add(row);
  }
  
  removeRow(Contact contact) {
    for (int i = 1; i < contactTable.rows.length; i++) {
      if (contactTable.rows[i].id == contact.email) {
        contactTable.rows[i].remove();
        break;
      }
    }
  }
  
  removeRows() { // but not the header row
    for (int i = contactTable.rows.length - 1; i > 0; i--) {  
      contactTable.rows[i].remove();
    }
  }
  
  editContact(Event e) {
    String email = (e.target as InputElement).value;
    var contact = contacts.singleWhereAttributeId('email', email);
    showSelectedContact(contact); 
  }
  
  removeSelection(Event e) {
    if ((e.target as Element).id == 'thEdit') {
      doNotShowSelectedContact();
    } 
  }
  
  showSelectedContact(Contact contact) {
    for (int i = 1; i < contactTable.rows.length; i++) {
      TableRowElement row = contactTable.rows[i];
      var imgInputElement = row.nodes[0].nodes[0] as InputElement;
      if (row.id == contact.email) {
        imgInputElement.src = 'img/check.png';
      } else {
        imgInputElement.src = 'img/edit.png';
      }
    }
    wc.currentContact = contact;
  }
  
  doNotShowSelectedContact() {
    for (int i = 1; i < contactTable.rows.length; i++) {
      TableRowElement row = contactTable.rows[i];
      var imgInputElement = row.nodes[0].nodes[0] as InputElement;
      imgInputElement.src = 'img/edit.png'; 
    }
    wc.currentContact = null;
  }
  
  toRemoveContact(Event e) {
    btnRemoveContact.style.display = 'inline';
    btnDoNotRemoveContact.style.display = 'inline';
    String email = (e.target as InputElement).value;
    var contact = contacts.singleWhereAttributeId('email', email);
    wc.currentContact = contact;
  }
  
  removeContactAfterConfirmation(Event e) {
    btnRemoveContact.style.display = 'none';
    btnDoNotRemoveContact.style.display = 'none';
    var removed = contacts.remove(wc.currentContact);
    if (removed) {
      removeRow(wc.currentContact);
      wc.save();
      doNotShowSelectedContact();
    }
  }
  
  doNotRemoveContact(Event e) {
    btnRemoveContact.style.display = 'none';
    btnDoNotRemoveContact.style.display = 'none';
    wc.currentContact = null;
    doNotShowSelectedContact();
  }
  
  changeSort(Event e) {
    switch ((e.target as Element).id) {
      case 'thEmail':
        contacts.sort((Contact c1, Contact c2) => c1.compareEmail(c2));
        break;
      case 'thLastName':
        contacts.sort();
        break;
    }   
    removeRows();
    display();
    if (wc.currentContact != null) {
      showSelectedContact(wc.currentContact);
    }
  }
}


