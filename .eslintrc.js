module.exports = {
    "rules": {
        "indent": [
            1,
            4
        ],
        "quotes": [
            1,
            "double"
        ],
        "linebreak-style": [
            2,
            "unix"
        ],
        "semi": [
            1,
            "always"
        ]
    },
    "env": {
        "es6": true,
        "browser": true
    },
    "extends": "eslint:recommended",
    "ecmaFeatures": {
        "jsx": true,
        "experimentalObjectRestSpread": true
    },
    "plugins": [
        "react"
    ]
};
