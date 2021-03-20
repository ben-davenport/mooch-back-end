var express = require('express');
var router = express.Router();
const db = require('../db');
const bcrypt = require('bcryptjs');
const randToken = require('rand-token');

/* GET users . */
router.get('/', function(req, res, next) {
  res.send('respond with a resource');
});

// data validation for sign up
router.post('/signup',(req, res, next)=>{
  const { first,last,email,password,city,state,street,about } = req.body;
  if((!first) || (!last) || (!email) || (!password) || (!city) || (!state) || (!street)){
    res.json({
      msg: "invalidData"
    });
    return;
  }
  /* data is valid, check if user exists
    if the email is new add the user to the db */
  const checkUserQuery = `SELECT * FROM users WHERE email = ?`
  db.query(checkUserQuery,[email],(err,results)=>{
    if(err){throw err}; //FULL STOP!!!!!
    if(results.length > 0){
      res.json({
        msg: "userExists"
      });
    }else{
      const insertUserQuery = `INSERT INTO users
        (first, last, email, password, city, state, street, about, token)
        VALUES
        (?,?,?,?,?,?,?,?,?)`
        // salt and hash the password for security
        const salt = bcrypt.genSaltSync(10);
        const hash = bcrypt.hashSync(password, salt);
        // create a token
        const token = randToken.uid(50);
        db.query(insertUserQuery,[first,last,email,hash, city, state, street, about, token],(err2)=>{
          if(err2){throw err2}
          res.json({
            msg: "userAdded",
            token,
            email,
            first
          })
        });
    }
  })
})

/* check login credentials
  if login exists and password is valid then
  return a valid token and basic user info */
router.post('/login',(req, res)=>{
  const { email, password } = req.body;
  
  const getUserQuery = `SELECT * FROM users WHERE email = ?`;
  db.query(getUserQuery,[email],(err, results)=>{
    if(err){throw err}
    if(results.length > 0){
      const thisRow = results[0];
      const isValidPass = bcrypt.compareSync(password,thisRow.password);
      if(isValidPass){
        const token = randToken.uid(50);
        const updateUserTokenQuery = `UPDATE users
          SET token = ? WHERE email = ?`
        db.query(updateUserTokenQuery,[token,email],(err)=>{
          if(err){throw err}
        });

        res.json({
          msg: "loggedIn",
          first: thisRow.first,
          last: thisRow.last,
          email: thisRow.email,
          about: thisRow.about,
          location: `${thisRow.street} ${thisRow.city}, ${thisRow.state}`,
          token,
        });
      }else{
        // incorrect password response
        res.json({
          msg: "badPass"
        })
      }

    }else{
      // no such user found
      res.json({
        msg: "noEmail"
      })
    }
  })
})

module.exports = router;
