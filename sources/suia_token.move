module suia_token::suia_token {
    use std::option;

    use sui::coin::{Self, Coin, TreasuryCap};
    use sui::transfer;
    use sui::tx_context::{Self, TxContext};
    use sui::url;

    struct SUIA_TOKEN has drop {}

    fun init(witness: SUIA_TOKEN, ctx: &mut TxContext) {
        let (treasury_cap, metadata) = coin::create_currency<SUIA_TOKEN>(witness,
            9,
            b"SUIA",
            b"SUIA",
            b"SUIA is the native token of Suia.io",
            option::some(url::new_unsafe_from_bytes(b"")),
            ctx);
        transfer::public_freeze_object(metadata);
        transfer::public_transfer(treasury_cap, tx_context::sender(ctx))
    }

    public entry fun mint(
        treasury_cap: &mut TreasuryCap<SUIA_TOKEN>, amount: u64, recipient: address, ctx: &mut TxContext
    ) {
        coin::mint_and_transfer(treasury_cap, amount, recipient, ctx)
    }

    public entry fun burn(treasury_cap: &mut TreasuryCap<SUIA_TOKEN>, coin: Coin<SUIA_TOKEN>) {
        coin::burn(treasury_cap, coin);
    }
}