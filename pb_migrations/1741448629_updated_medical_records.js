/// <reference path="../pb_data/types.d.ts" />
migrate((app) => {
  const collection = app.findCollectionByNameOrId("pbc_2888295135")

  // add field
  collection.fields.addAt(7, new Field({
    "cascadeDelete": false,
    "collectionId": "pbc_220866482",
    "hidden": false,
    "id": "relation532658393",
    "maxSelect": 1,
    "minSelect": 0,
    "name": "prescription",
    "presentable": false,
    "required": false,
    "system": false,
    "type": "relation"
  }))

  return app.save(collection)
}, (app) => {
  const collection = app.findCollectionByNameOrId("pbc_2888295135")

  // remove field
  collection.fields.removeById("relation532658393")

  return app.save(collection)
})
