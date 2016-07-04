module.exports = {
    "globals": {
        "$": true,
        "google": true,
    },
    "rules": {
        "indent": [
            1,
            2
        ],
        "quotes": [
            1,
            "single"
        ],
        "linebreak-style": [
            2,
            "unix"
        ],
        "semi": [
            0,
            "always"
        ],
        "comma-dangle": [
            0,
        ],
        "no-unused-vars": [
            1,
        ]
    },
    "env": {
        "es6": true,
        "browser": true,
        "node": true
    },
    "extends": "eslint:recommended",
    "parserOptions": {
        "ecmaVersion": 6,
        "sourceType": "module",
        "ecmaFeatures": {
            "jsx": true
        },
    },
    "plugins": [
        "react"
    ]
};
