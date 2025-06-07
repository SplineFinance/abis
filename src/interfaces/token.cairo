#[starknet::interface]
pub trait ILiquidityProviderToken<TStorage> {
    // returns the mint/burn authority of the lp token
    fn authority(self: @TStorage) -> starknet::ContractAddress;

    // mints an amount of lp tokens to `to`
    fn mint(ref self: TStorage, to: starknet::ContractAddress, amount: u256);

    // burns an amount of lp tokens from `from`
    fn burn(ref self: TStorage, from: starknet::ContractAddress, amount: u256);
}
