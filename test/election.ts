import { Client, Provider, ProviderRegistry, Result } from "@blockstack/clarity";
import { assert } from "chai";
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
