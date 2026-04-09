💸 Expense Tracking System

A lightweight, mobile-first expense tracking system built with simple, free tools.

⸻

🧱 Overview

This project allows you to quickly log expenses from your phone and store them in Google Sheets.

Stack
	•	Frontend → Static Web App (GitHub Pages)
	•	Backend → Google Apps Script (Web API)
	•	Database → Google Sheets

⸻

🧭 Architecture

User (Mobile Web App)
        ↓ POST (JSON)
Google Apps Script (API)
        ↓
Google Sheets (Database)


⸻

📱 Frontend (Web App)

Features
	•	Mobile-first UI
	•	Fast input flow

Fields:
	•	💰 Value (max 2 decimals)
	•	📝 Description
	•	📅 Date (native picker)
	•	🏦 Wallet (dropdown)
	•	📂 Category (grouped selector with search)

⸻

Category UX
	•	Navigate: Group → Category
	•	Back button
	•	Cancel button
	•	Search across groups and categories

⸻

📡 Example Request

{
  "key": "YOUR_SECRET_KEY",
  "value": 25.50,
  "description": "Lunch",
  "date": "2026-04-08",
  "category": "Restaurante",
  "wallet": "Conta 1"
}


⸻

⚙️ Backend (Google Apps Script)

Purpose

Receives POST requests and appends data to Google Sheets.

Code

function doPost(e) {
  const sheet = SpreadsheetApp.getActiveSpreadsheet().getSheetByName("Sheet1");
  
  const data = JSON.parse(e.postData.contents);
  const SECRET = "YOUR_SECRET_KEY";

  if (data.key !== SECRET) {
    return ContentService.createTextOutput("Unauthorized");
  }

  sheet.appendRow([
    new Date(),
    data.date,
    data.value,
    data.description,
    data.category,
    data.wallet
  ]);

  return ContentService.createTextOutput("Success");
}


⸻

🚀 Deployment (Backend)
	1.	Open Google Apps Script
	2.	Paste the code
	3.	Click Deploy → Web App
	4.	Set:
	•	Execute as: Me
	•	Access: Anyone
	5.	Copy the generated URL
	6.	Use it in your frontend as API_URL

⸻

📊 Google Sheets (Database)

Structure

Timestamp	Date	Value	Description	Category	Wallet


Notes
	•	Timestamp is automatic
	•	Date is selected by user
	•	Value is numeric
	•	Category and Wallet are predefined

⸻

📂 Categories

const categories = {
  "Alimentação": ["Restaurante", "Supermercado"],
  "Transporte": ["Uber", "Combustível"]
};

You can fully customize this structure.

⸻

🔐 Security

Secret Key

"key": "YOUR_SECRET_KEY"

Notes
	•	Prevents random spam requests
	•	Not fully secure (key is visible in frontend)
	•	Suitable for personal use

⸻

🌐 Hosting
	•	Hosted with GitHub Pages
	•	Accessible via browser
	•	Can be added to iPhone Home Screen

⸻

📡 Offline Behavior
	•	UI may load offline (cached)
	•	Submissions require internet
	•	No retry system (can be added)

⸻

🚀 Future Improvements

UX
	•	Replace alerts with inline validation
	•	Confirmation screen before submit
	•	Remember last used wallet/category

Features
	•	Offline queue (retry failed submissions)
	•	Expense history screen
	•	Edit / delete entries

Analytics
	•	Monthly summaries
	•	Charts by category or wallet

Security
	•	Rate limiting
	•	Token rotation
	•	OAuth authentication

⸻

🧠 Design Philosophy
	•	Speed over complexity
	•	Mobile-first
	•	Minimal friction
	•	Use simple tools instead of heavy infrastructure

⸻

📌 How to Use
	1.	Open the web app
	2.	Fill in:
	•	Value
	•	Description
	•	Date
	•	Category
	•	Wallet
	3.	Tap Save
	4.	Data is instantly stored in Google Sheets

⸻

✅ Summary
	•	Simple and fast expense tracking
	•	Full control of your data
	•	No dependencies
	•	Zero cost to run

⸻

🏁 Final Note

Designed for practical daily use with focus on speed, simplicity, and reliability.