const express = require('express');
const admin = require('firebase-admin');
const serviceAccount = require('C:\\Users\\a7med\\Desktop\\educatly-47487-firebase-adminsdk-axvzi-64847f5201.json');

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount)
});

const auth = admin.auth();
const app = express();
const port = 3000;

app.get('/users', async (req, res) => {
  try {
    const listUsersResult = await auth.listUsers(1000);
    const users = listUsersResult.users.map(userRecord => userRecord.toJSON());
    res.json(users);
  } catch (error) {
    console.log('Error listing users:', error);
    res.status(500).send('Error retrieving users');
  }
});

app.listen(port, () => {
  console.log(`Server listening at http://localhost:${port}`);
});
