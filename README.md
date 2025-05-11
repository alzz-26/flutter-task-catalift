# Catalift-task

- UI implementation as received in email

## Features implemented

- Email/Password and Google-Sign-In login/signup methods using Firebase 
- Logout 
- App restart routing based on user authentication state
- Navigation to education_details_page and then to interests_page for new users directly after registration
- For older users, navigation is set to Dashboard Page on app start
- Local storage of data (interests, education info, etc) in each session using Provider state management
- Displaying of information stored in each session in Dashboard using Provider state management
- Edit option only for either education_details_page or interests_page through Dashboard page

## Future implementations

- UI enhancement of remaining pages.
- Using Firestore for database instead of local storage
- Modifying routing logics to avoid glitches