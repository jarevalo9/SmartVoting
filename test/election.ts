import { Client, Provider, ProviderRegistry, Result } from "@blockstack/clarity";
import { assert, expect } from "chai";
import { add-candidate } from "././contracts/election.clar";

describe("voting contract test suite", () => {
  let electionClient: Client;
  let provider: Provider;
  before(async () => {
    provider = await ProviderRegistry.createProvider();
    electionClient = new Client("SP3GWX3NE58KXHESRYE4DYQ1S31PQJTCRXB3PE9SB.election", "election", provider);
  });
  it("should have a valid syntax", async () => {
    await electionClient.checkContract();
  });
})

describe("testing adding voters", () =>{
    it("it should add the candidate 1 ", () => {
        expect(add-candidate("candidate1").true)
    });
});
