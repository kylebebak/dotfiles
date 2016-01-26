module.exports = {
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
            1,
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
    "ecmaFeatures": {
        "modules": true,
        "jsx": true,
        "forOf": true,
        "experimentalObjectRestSpread": true
    },
    "plugins": [
        "react"
    ]
};
