var kbpgp = require('kbpgp');


var alice_pgp_key = `
-----BEGIN PGP PUBLIC KEY BLOCK-----
Version: GnuPG v1

mQENBFpnDcgBCAC+9Xifo4s9VhSbcqR/G+D57mu797kPdCwBd6NRp2pHYlLu4p9v
W14o+zgXqW4iP7kkTtukjpG2ckZSHhsqk2shng1kMxuUbZDpgceDp0/isdOQT3Gp
RxHr1alECx5lgF8Xebvoj7lk2gVlDdSPAox+3O4PRBfCvPfHeK3ydhsh6jrY4Ea4
u+zekMXPAtZA+YE9jiwocj/zdQTHR66uQkqAUwZiHuYsYONeTKDaJyKG/R6ZzZ9f
m2GWmmIymTn4YoNiEV0ClZtsrHhi+jUQ/9LJlXZkV9SzzcNy9fI+XWi92dbNlRB+
AfTP8WILPcj4sHOYm7m8eo7Cfi5FDL1fC26RABEBAAG0NE9wZHJhY2h0bmVtZXIg
KE9wZHJhY2h0bmVtZXIpIDxPcGRyYWNodG5lbWVyQGlycC5ubD6JATgEEwECACIF
AlpnDcgCGwMGCwkIBwMCBhUIAgkKCwQWAgMBAh4BAheAAAoJEP8FXwuJuYBM+P8I
AJmT2Sq2QDG0ahfepFa6EDm1E78V71qy0kOQ+DjbZ06SmMXgKksxMXU/sMTAP7o9
ba/PWZDjWLW0G34NHyCTQH3VfLA+spwtF5Sddgca2AXm1CITgWXJ8AQIijo2IBSi
2/WVlDSv+p8Woff6XCRlI+3VVbXne5giJQf7/CdB/fhZcbtdqoVs/5PysdbYwUfP
JotzoTR2w+h4heS6gGwCEejF2CNc4/5j8FgigMXGquCmDDyjcTZq25uzqKE9jDZq
4ANlAPWdPcs5Nz/M9MY4sCElJvR1Gk0AUzZN8rtohVwuYobgCGr7z9S0HTfJIJyX
dY7BWTU//FGxku2PLouHVUu5AQ0EWmcNyAEIAMOiLsLo9CYVofLvDhyJRM0DP+Ma
ihq+8hGN5PGbq159xg06UYAG++mngvn8GtBmcbQt6VuqJq3iaWNoeyZFN7LHVnGf
IBLrLeUnOE2yGQi/JOZOMEDnNiU12Yd7mTLo0Fa8lWn3ulupdJ8aZSTfEF3dMX9L
oH203pfT51DGf+Hepm60E4matjmxufijwSIAxeb/U+HjSyqkcudx/nVptr7FzpwU
ZNW8J0fo3T6FwMLaOpWXrGlm7RwkmzLviuVOvAedmQs+lxBUV2ULbI296q4YmdUb
/U05h27N9vQ9a9hEXpszWf0EXzJpOU2or80wdPlrw+ABwswee3D2YUHAX98AEQEA
AYkBHwQYAQIACQUCWmcNyAIbDAAKCRD/BV8LibmATA49B/9uR/7aFnd3k2OXQza4
OxsxOJ3sLwNt4/rEzm/xt8iJ/Xh/G4Z09uefG9NxLJ+XkO1NImO0QByA6ktpPiFX
ySTfTb/+7+eKgpPP6la9Rq4v/grbqZCllGPfRe2jAnIhBqoleI+2pmFtwiKJDEEr
Lmudla8jpVQ7nHN0uxpltfFuuWK7DynKc1C/sk9qn2XbLAVOfJuuUICA6M5aTkxy
57zjwV0atCTwZofoRFWQcLTCRFiOTaE+V/FsCotZ342EWT7v4IWsRinmKHrCKIzQ
HiYA6Gl4fJTyUmhQGevR9Fjjtb8zJ8JWsxQu75GpLBx9bkwwM/R0A9FZA3YeZ0F6
kRnW
=/jSW
-----END PGP PUBLIC KEY BLOCK-----
`;

var chuck_pgp_key = `
-----BEGIN PGP PRIVATE KEY BLOCK-----
Version: GnuPG v1

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
QHyPiN8=
=v9LW
-----END PGP PRIVATE KEY BLOCK-----
`;

var chuck_passphrase = "Pulse123!";

kbpgp.KeyManager.import_from_armored_pgp({
    armored: alice_pgp_key
}, function (err, alice) {
    if (!err) {
        console.log("alice is loaded");

        kbpgp.KeyManager.import_from_armored_pgp({
            armored: chuck_pgp_key
        }, function (err, chuck) {
            if (!err) {
                if (chuck.is_pgp_locked()) {
                    chuck.unlock_pgp({
                        passphrase: chuck_passphrase
                    }, function (err) {
                        if (!err) {
                            console.log("Loaded private key with passphrase");

                            var params = {
                                encrypt_for: alice,
                                sign_with: chuck,
                                msg: "Hey Alice - my bitcoin address is 1alice12345234..."
                            };

                            kbpgp.box(params, function (err, result_string, result_buffer) {
                                console.log(">>>", err, result_string, result_buffer);
                            });
                        }
                    });
                } else {
                    console.log("Loaded private key w/o passphrase");

                    var params = {
                        encrypt_for: alice,
                        sign_with: chuck,
                        msg: "Hey Alice - my bitcoin address is 1alice12345234..."
                    };

                    kbpgp.box(params, function (err, result_string, result_buffer) {
                        console.log("<<<", err, result_string, result_buffer);
                    });
                }
            }
        });
    }
});
