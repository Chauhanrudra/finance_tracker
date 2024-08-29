const express = require('express');
const router = express.Router();
const Transaction = require('../models/Transaction');

// @route    POST /transactions
// @desc     Add a new transaction
router.post('/', async (req, res) => {
    try {
        const newTransaction = new Transaction(req.body);
        const transaction = await newTransaction.save();
        res.json(transaction);
    } catch (error) {
        res.status(500).send('Server Error');
    }
});

// @route    GET /transactions
// @desc     Get all transactions
router.get('/', async (req, res) => {
    try {
        const transactions = await Transaction.find();
        res.json(transactions);
    } catch (error) {
        res.status(500).send('Server Error');
    }
});

// Additional routes for updating and deleting transactions will go here

module.exports = router;
