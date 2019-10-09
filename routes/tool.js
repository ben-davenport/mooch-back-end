var express = require('express');
var router = express.Router();
const db = require('../db');
const fs = require('fs');

//    post('/tool/tools')
router.post('/addTool',
(req, res)=>{
        console.log(req.body);
    //   console.log(req.file);
    //   console.log(res.locals);
    if(!res.locals.loggedIn){
        res.json({
            msg: "badToken"
        })
        return;
    }

    const { title, details, category, availability, token } = req.body
    const f = req.file;
    const finalFilePath = f.destination+'/'+Date.now()+f.originalname;
    const filePathForDb = finalFilePath.slice(8)
    fs.rename(f.path, finalFilePath,(err)=>{
        if(err) throw err;
    })

    const insertHomeQuery = `INSERT INTO tools
        (uid, title, details, category, availability, imageUrl)
            VALUES 
        (?,?,?,?,?,?)`;
    const dbValues = [res.locals.uid,title,details,category,availability,filePathForDb];
    db.query(insertHomeQuery,dbValues,(err)=>{
        if(err) throw err;
        res.json({
            msg: "toolAdded"
        })
    })
});

module.exports = router;
