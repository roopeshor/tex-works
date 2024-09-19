#include <iostream>
#include <fstream>
#include <string>
#include <vector>
#include <sstream> // for reading a single line from file
#include <algorithm> // for transform function

#define FILENAME "contacts.txt"
using namespace std;

/// ====Working====

/// The program first reads the file named "contacts.txt" and converts it
/// to a list that lives inside program's memory. Here a struct is used
/// to store a single contact. Using a struct makes it easy to from
/// arrays and do operations on it.
/// Contacts are stored in the file in CSV (comma separated value) format
/// CSV is basically a simple spreadsheet, where each
/// entry is separated by a comma. e.g:

/// name,ID
/// Amil,900192
/// Dev,900223



struct Contact {
	string name;
	string phone_number;
};


/// Utility function. Converts a string to lowercase
void toLower(string& str) {
	transform(str.begin(), str.end(), str.begin(), ::tolower);
}


/// reads the contact file and loads them to program's memory.
/// ie, it reads the file converts it to a Contactvector and returns it.
vector<Contact> loadContacts() {
	// A vector is a basically a resizable array. You can
	// easily add, remove or edit elements from a vector 
	vector<Contact> contacts;
	ifstream file(FILENAME);
	if (file.is_open()) {
		string line;
		// reads all lines in the file
		while (getline(file, line)) {
			stringstream ss(line);
			string name, phone_number;

			// reads the line upto a comma and stores it to name
			getline(ss, name, ',');
			// reads the rest of the line and stores it to phone_number.
			getline(ss, phone_number);
			// adds the the details to contacts vector
			contacts.push_back({name, phone_number});
		}
		file.close();
	}
	return contacts;
}

// saves contacts in program memory to the file
void saveContacts(vector<Contact>& contacts) {
	ofstream file(FILENAME);
	if (file.is_open()) {
		for (int i = 0; i < contacts.size(); i++) {
			Contact contact = contacts[i];
			// adds new contact in the format:
			//     name,phone number
			file <<
				contact.name << "," << contact.phone_number
				<< endl;
		}
		file.close();
	}
}

/// lists contacts
void listContacts(vector<Contact>& contacts) {
	if (contacts.empty()) {
		cout << "No contacts found." << endl;
		return;
	}

	cout << "Contacts:" << endl;
	for (int i = 0; i < contacts.size(); ++i) {

		// it is nice to start numbering the contact from 1
		cout << i + 1 << ". "
				 << contacts[i].name << " - "
				 << contacts[i].phone_number << endl;
	}
}

// creates a new contact by asking name & phone number from user
void createContact(vector<Contact>& contacts) {
	string name, phone_number;
	cout << "Name: ";
	getline(cin, name);
	cout << "Phone number: ";
	getline(cin, phone_number);
	// push_back function adds a new element at the end of vector
	contacts.push_back({name, phone_number});

	// New contact only exists in program's memory
	// call this function to save the contact to the file.
	saveContacts(contacts);
	cout << "Contact added successfully" << endl;
}

/// Asks user to input a index. The function validates the index
/// and returns it if its valid. if its not valid it returns -1
int getIndexFromUser(int maxIndex) {
	int index;
	cout << "Enter contact index to edit: ";
	cin >> index;
	cin.ignore();
	
	// given index must be between 1 to N (N = numebr of contacts)
	if (index > maxIndex || index < 1) {
		cout << "invalid index" << endl;
		return -1;
	}

	// index starts from 0 in the vector
	// but we're asking user to input from 1 (as we're printing from 1)
	// so decrease index by 1
	return index - 1;
}

/// edits a contact based on the position of the
/// contact (number that is displayed on the list)
void editContact(vector<Contact>& contacts) {
	int index = getIndexFromUser(contacts.size());
	if (index < 0) return;

	string old_name = contacts[index].name;
	string old_phone = contacts[index].phone_number;
	string new_name, new_phone_number;

	cout << "Enter new name (" << old_name << "): ";
	getline(cin, new_name);
	if (!new_name.empty()) {
		contacts[index].name = new_name;
	}

	cout << "Enter new phone number (" << old_phone << "): ";
	getline(cin, new_phone_number);
	if (!new_phone_number.empty()) {
		contacts[index].phone_number = new_phone_number;
	}

	saveContacts(contacts);
	cout << "Contact edited successfully" << endl;
}

/// Deletes contact at a particular location
void deleteContact (vector<Contact>& contacts) {
	int index = getIndexFromUser(contacts.size());
	if (index < 0) return;
	contacts.erase(contacts.begin() + index);
	saveContacts(contacts);
	cout << "Contact deleted successfully" << endl;
}

/// returns index of all contacts whose name contains the
/// name we're searching (searchQuery). The function
/// goes through all contacts and checks for any match
vector<int> matchingContactIndexes(
	vector<Contact>& contacts,
	string searchQuery
) {
	// we want match both lower and upper case names
	// easiest way to do is to convert both strings (name & query)
	// to lowercase
	toLower(searchQuery);

	vector<int> foundIndexes;
	for (int i = 0; i < contacts.size(); i++) {
		string name = contacts[i].name;
		toLower(name);
		// name.find() returns the starting index where our substring starts.
		// it returns a special value (npos) if it can't find the string
		// we're searching
		if (name.find(searchQuery) != string::npos) {
			foundIndexes.push_back(i);
		}
	}
	return foundIndexes;
}

/// takes a search query from user and lists all matching names
/// from the contacts
void searchContact(vector<Contact>& contacts) {
	string name;
	cout << "Enter name to search: ";
	getline(cin, name);

	vector<int> matchingIndexes = matchingContactIndexes(contacts, name);
	if (matchingIndexes.empty()) {
		cout << "No contacts found" << endl;
		return;
	}

	cout << endl; // just print a blank line to separate the result
	for (int i = 0; i < matchingIndexes.size(); i++) {
		int index = matchingIndexes[i];
		cout << contacts[index].name
			<< " - " << contacts[index].phone_number << endl;
	}
}

int main() {
	vector<Contact> contacts = loadContacts();

	int choice;
	cout << endl << "------Contact Manager------";
	do {
		cout << endl;
		cout << "(1) List  (2) Find   (3) Create" << endl;
		cout << "(4) Edit  (5) Delete (6) Exit" << endl;
		cout << "Enter your choice: ";
		cin >> choice;

		// Usually cin reads everything and leaves new line character.
		// When getline function is used somewhere after cin, it will
		// read this line and interprets that user has skipped the input.
		// So the getline function won't read the input. To avoid that
		// cin.ignore will remove any new line character from being passed
		// to getline function.
		cin.ignore();
		// we can't use getline to read integers. The function only reads strings.
		
		switch (choice) {
			case 1:
				listContacts(contacts);
				break;
			case 2:
				searchContact(contacts);
				break;
			case 3:
				createContact(contacts);
				break;
			case 4:
				editContact(contacts);
				break;
			case 5:
				deleteContact(contacts);
				break;
			case 6:
				saveContacts(contacts);
				cout << "Exiting..." << endl;
				break;
			default:
				cout << "Invalid choice." << endl;
		}

	} while (choice != 6);

	return 0;
}
