/// <reference path="../pb_data/types.d.ts" />
migrate((app) => {
  const collection = app.findCollectionByNameOrId("pbc_2888295135")

  // add field
  collection.fields.addAt(3, new Field({
    "autogeneratePattern": "",
    "hidden": false,
    "id": "text2127630141",
    "max": 0,
    "min": 0,
    "name": "diagnosis",
    "pattern": "",
    "presentable": false,
    "primaryKey": false,
    "required": false,
    "system": false,
    "type": "text"
  }))

  // add field
  collection.fields.addAt(4, new Field({
    "hidden": false,
    "id": "date2144698386",
    "max": "",
    "min": "",
    "name": "visitDate",
    "presentable": false,
    "required": false,
    "system": false,
    "type": "date"
  }))

  // add field
  collection.fields.addAt(5, new Field({
    "autogeneratePattern": "",
    "hidden": false,
    "id": "text2550217777",
    "max": 0,
    "min": 0,
    "name": "treatment",
    "pattern": "",
    "presentable": false,
    "primaryKey": false,
    "required": false,
    "system": false,
    "type": "text"
  }))

  // add field
  collection.fields.addAt(6, new Field({
    "hidden": false,
    "id": "bool1212927008",
    "name": "isFollowUpRequired",
    "presentable": false,
    "required": false,
    "system": false,
    "type": "bool"
  }))

  return app.save(collection)
}, (app) => {
  const collection = app.findCollectionByNameOrId("pbc_2888295135")

  // remove field
  collection.fields.removeById("text2127630141")

  // remove field
  collection.fields.removeById("date2144698386")

  // remove field
  collection.fields.removeById("text2550217777")

  // remove field
  collection.fields.removeById("bool1212927008")

  return app.save(collection)
})
