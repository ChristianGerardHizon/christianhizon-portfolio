/// <reference path="../pb_data/types.d.ts" />
migrate((app) => {
  const collection = app.findCollectionByNameOrId("pbc_1820489269")

  // add field
  collection.fields.addAt(12, new Field({
    "hidden": false,
    "id": "file3534992897",
    "maxSelect": 1,
    "maxSize": 0,
    "mimeTypes": [],
    "name": "displayImage",
    "presentable": false,
    "protected": false,
    "required": false,
    "system": false,
    "thumbs": [],
    "type": "file"
  }))

  return app.save(collection)
}, (app) => {
  const collection = app.findCollectionByNameOrId("pbc_1820489269")

  // remove field
  collection.fields.removeById("file3534992897")

  return app.save(collection)
})
