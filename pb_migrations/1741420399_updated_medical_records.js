/// <reference path="../pb_data/types.d.ts" />
migrate((app) => {
  const collection = app.findCollectionByNameOrId("pbc_2888295135")

  // add field
  collection.fields.addAt(1, new Field({
    "hidden": false,
    "id": "bool2382110195",
    "name": "isDeleted",
    "presentable": false,
    "required": false,
    "system": false,
    "type": "bool"
  }))

  // add field
  collection.fields.addAt(2, new Field({
    "cascadeDelete": false,
    "collectionId": "pbc_1820489269",
    "hidden": false,
    "id": "relation450549739",
    "maxSelect": 1,
    "minSelect": 0,
    "name": "patient",
    "presentable": false,
    "required": false,
    "system": false,
    "type": "relation"
  }))

  return app.save(collection)
}, (app) => {
  const collection = app.findCollectionByNameOrId("pbc_2888295135")

  // remove field
  collection.fields.removeById("bool2382110195")

  // remove field
  collection.fields.removeById("relation450549739")

  return app.save(collection)
})
