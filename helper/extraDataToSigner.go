package helper

import (
	"github.com/ethereum/go-ethereum/common"
	"github.com/ethereum/go-ethereum/core/types"
	"github.com/ethereum/go-ethereum/crypto"
	"github.com/ethereum/go-ethereum/rlp"
	"github.com/itzmeanjan/ette/app/db"
	"golang.org/x/crypto/sha3"
	"log"
	//"signerUpgrader/dbOperation"
)

func UpdateMinerToSigner(block *db.PackedBlock, blk *types.Block) error {
	//公钥
	pubkey, err := crypto.SigToPub(sigHash(blk.Header()).Bytes(), blk.Extra()[32:])
	if err != nil || pubkey == nil {
		log.Printf("cannot get signer for block #%v", blk.Number().Int64())
		return err
	} else {
		//存入公钥地址
		signerAddress := crypto.PubkeyToAddress(*pubkey).Hex()
		//存入数据库
		block.Block.Miner = signerAddress
		return nil
	}
}

//签名hash
func sigHash(header *types.Header) (hash common.Hash) {
	hasher := sha3.NewLegacyKeccak256()

	rlp.Encode(hasher, []interface{}{
		header.ParentHash,
		header.UncleHash,
		header.Coinbase,
		header.Root,
		header.TxHash,
		header.ReceiptHash,
		header.Bloom,
		header.Difficulty,
		header.Number,
		header.GasLimit,
		header.GasUsed,
		header.Time,
		header.Extra[:len(header.Extra)-65],
		header.MixDigest,
		header.Nonce,
	})
	hasher.Sum(hash[:0])
	return hash
}
