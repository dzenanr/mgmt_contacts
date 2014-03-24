part of mgmt_contacts_app;

class ContactTable {
  TableElement _contactTable = querySelector('#contact-table');

  ContactTable(Contacts contacts) {
    for (Contact contact in contacts) {
      TableRowElement row = new Element.tr();
      
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
  }
}


