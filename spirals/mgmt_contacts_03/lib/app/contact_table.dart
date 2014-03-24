part of mgmt_contacts_app;

class ContactTable {
  Contacts contacts;
  
  ContactsApp app; 
  TableElement _contactTable = querySelector('#contact-table');

  ContactTable(this.app) {
    contacts = app.model.contacts;
    display();
  }
  
  display() {
    for (Contact contact in contacts) {
      addRow(contact);
    }  
  }
  
  addRow(Contact contact) {
    TableRowElement row = new Element.tr();
    
    TableCellElement tdEdit = new Element.td();
    InputElement imgEdit = new InputElement();
    imgEdit.type = 'image';
    imgEdit.src = 'img/edit.png';
    imgEdit.title = 'Edit this contact';
    imgEdit.value = contact.email; 
    imgEdit.onClick.listen(editContact);
    tdEdit.nodes.add(imgEdit);
    row.nodes.add(tdEdit);
    
    TableCellElement tdRemove = new Element.td();
    InputElement imgRemove = new InputElement();
    imgRemove.type = 'image';
    imgRemove.src = 'img/remove.png';
    imgRemove.title = 'Remove this contact';
    imgRemove.value = contact.email; 
    imgRemove.onClick.listen(removeContact);
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
    _contactTable.nodes.add(row);
  }
  
  bool removeRow(Contact contact) {
    for (int i = 1; i < _contactTable.rows.length; i++) {
      if (_contactTable.rows[i].id == contact.email) {
        _contactTable.rows[i].remove();
        return true;
      }
    }
    return false;
  }
  
  editContact(Event e) {
    String email = (e.target as InputElement).value;
    var currentContact = contacts.singleWhereAttributeId('email', email);
    app.currentContact = currentContact;
    showSelectedContact(email);       
  }
  
  showSelectedContact(String email) {
    for (int i = 1; i < _contactTable.rows.length; i++) {
      TableRowElement row = _contactTable.rows[i];
      if (row.id == email) {
        (row.nodes[0].nodes[0] as InputElement).src = 'img/check.png';
      }
      else {
        (row.nodes[0].nodes[0] as InputElement).src = 'img/edit.png';
      }
    }
  }
  
  removeContact(Event e) {
    String email = (e.target as InputElement).value;
    var contact = contacts.singleWhereAttributeId('email', email);
    var removed = contacts.remove(contact);
    if (removed) {
      var rowRemoved = removeRow(contact);
      assert(rowRemoved);
      app.save();
      app.currentContact = null;
    }
  }
}


