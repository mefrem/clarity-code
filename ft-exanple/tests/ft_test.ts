import {
  Clarinet,
  Tx,
  Chain,
  Account,
  types,
} from "https://deno.land/x/clarinet@v1.4.0/index.ts";
import { assertEquals } from "https://deno.land/std@0.170.0/testing/asserts.ts";

Clarinet.test({
  name: "Ensure that contract minting 100 tokens has that balance.",
  async fn(chain: Chain, accounts: Map<string, Account>) {
    let wallet_1 = accounts.get("wallet_1");
    let block = chain.mineBlock([
      Tx.contractCall("ft", "mint", [types.uint(100)], wallet_1.address),
    ]);
    assertEquals(block.receipts.length, 1);
    assertEquals(block.height, 2);
    block.receipts[0].result.expectOk();

    block = chain.mineBlock([
      Tx.contractCall(
        "ft",
        "get-balance",
        [types.principal("ST1SJ3DTE5DN7X54YDH5D64R3BCB6A2AG2ZQ8YPD5")],
        wallet_1.address
      ),
    ]);
    assertEquals(block.receipts.length, 1);
    assertEquals(block.height, 3);
    block.receipts[0].result.expectOk().expectUint(100);
  },
});
