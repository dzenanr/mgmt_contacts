library contact_table_wc;

import 'dart:html'; 

import 'package:mgmt_contacts/mgmt_contacts.dart';
import 'package:mgmt_contacts/mgmt_contacts_app.dart';

part 'contact_table_wc/contact_form.dart';
part 'contact_table_wc/contact_table.dart';

class ContactTableWc {
  ContactsEntries model;
  Contact _currentContact;
  
  ContactsApp app;
  ContactTable contactTable;
  ContactForm contactForm;
  
  ContactTableWc(this.app) {
    model = app.model;
    contactTable = new ContactTable(this);
    contactForm = new ContactForm(this);
  }
  
  Contact get currentContact => _currentContact;
  set currentContact(Contact contact) {
    _currentContact = contact;
    contactForm.setFields(contact);
  }
  
  save() {
    app.save();
  }
}