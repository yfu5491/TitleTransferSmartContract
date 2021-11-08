const Buycar = artifacts.require("Buycar");

contract("Buycar", (accounts) => {
 let buycar;
 let expectedBuyer;

 before(async () => {
    buycar = await Buycar.deployed();
 });

 describe("buying a car and retrieving account addresses", async () => {
   before("buy a car using accounts[0]", async () => {
     await buycar.buy(5, { from: accounts[0] });
     expectedBuyer = accounts[0];
   });
   it("can fetch the address of an owner by car id", async () => {
    const buyer = await buycar.buyers(5);
    assert.equal(buyer, expectedBuyer, "The owner of the adopted pet should be the first account.");
    });
    it("can fetch the collection of all pet owners' addresses", async () => {
        const buyers = await buycar.getBuyers();
        assert.equal(buyers[5], expectedBuyer, "The owner of the adopted pet should be in the collection.");
       });
 });
});