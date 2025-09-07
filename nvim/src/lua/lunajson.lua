-- Lunajson is a pure Lua JSON library.
--
-- You can encode and decode JSON data using the `lunajson` module.
--
-- See my usage example in "jnni_additions/init.lua"
--
local newdecoder = require 'lunajson.decoder'
local newencoder = require 'lunajson.encoder'
local sax = require 'lunajson.sax'
-- If you need multiple contexts of decoder and/or encoder,
-- you can require lunajson.decoder and/or lunajson.encoder directly.
return {
	decode = newdecoder(),
	encode = newencoder(),
	newparser = sax.newparser,
	newfileparser = sax.newfileparser,
}
