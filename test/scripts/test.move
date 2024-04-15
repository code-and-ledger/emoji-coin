module tester::test {
    use aptos_framework::coin;
    use std::string;

    struct TakeOne {}

    public entry fun emoji_coin(caller: &signer, emoji: vector<u8>) {
        // coin with emoji
        let (burn_cap, freeze_cap, mint_cap) = coin::initialize<TakeOne>(
            caller,
            string::utf8(emoji),
            string::utf8(emoji),
            9,
            false,
        );  
        
        coin::register<TakeOne>(caller);
        let coins = coin::mint<TakeOne>(1000000000000, &mint_cap);
        coin::deposit<TakeOne>(@tester, coins);

        coin::destroy_freeze_cap<TakeOne>(freeze_cap);
        coin::destroy_mint_cap<TakeOne>(mint_cap);
        coin::destroy_burn_cap<TakeOne>(burn_cap);
    }
}