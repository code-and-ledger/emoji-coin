module owner::emoji_coin {
    use aptos_framework::coin;
    use std::string;

    struct EmojiCoin {}

    struct EmojiWithNameCoin {}

    public entry fun emoji_coin(caller: &signer) {
        // coin with emoji
        let (burn_cap, freeze_cap, mint_cap) = coin::initialize<EmojiCoin>(
            caller,
            string::utf8(x"F09F9880"),
            string::utf8(x"F09F9880"),
            9,
            false,
        );  
        
        coin::register<EmojiCoin>(caller);
        let coins = coin::mint<EmojiCoin>(1000000000000, &mint_cap);
        coin::deposit<EmojiCoin>(@owner, coins);

        coin::destroy_freeze_cap<EmojiCoin>(freeze_cap);
        coin::destroy_mint_cap<EmojiCoin>(mint_cap);
        coin::destroy_burn_cap<EmojiCoin>(burn_cap);
    }

    public entry fun emoji_coin_with_name(caller: &signer) {
        let emoji_name = string::utf8(b"face ");
        let emoji_utf8 = string::utf8(x"F09F9880");
        string::append(&mut emoji_name, emoji_utf8);

        // coin with name and emoji
        let (burn_cap, freeze_cap, mint_cap) = coin::initialize<EmojiWithNameCoin>(
            caller,
            emoji_name,
            emoji_name,
            9,
            false,
        );

        coin::register<EmojiWithNameCoin>(caller);
        let coins = coin::mint<EmojiWithNameCoin>(1000000000000, &mint_cap);
        coin::deposit<EmojiWithNameCoin>(@owner, coins);

        coin::destroy_freeze_cap<EmojiWithNameCoin>(freeze_cap);
        coin::destroy_mint_cap<EmojiWithNameCoin>(mint_cap);
        coin::destroy_burn_cap<EmojiWithNameCoin>(burn_cap);
    }
}