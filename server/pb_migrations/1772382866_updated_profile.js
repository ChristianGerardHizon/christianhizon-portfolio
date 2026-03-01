/// <reference path="../pb_data/types.d.ts" />
migrate((app) => {
  const collection = app.findCollectionByNameOrId("pbc_268752357")

  // add field
  collection.fields.addAt(14, new Field({
    "hidden": false,
    "id": "json1464297386",
    "maxSize": 0,
    "name": "stats",
    "presentable": false,
    "required": false,
    "system": false,
    "type": "json"
  }))

  // add field
  collection.fields.addAt(15, new Field({
    "autogeneratePattern": "",
    "hidden": false,
    "id": "text843438578",
    "max": 0,
    "min": 0,
    "name": "availabilityStatus",
    "pattern": "",
    "presentable": false,
    "primaryKey": false,
    "required": false,
    "system": false,
    "type": "text"
  }))

  // add field
  collection.fields.addAt(16, new Field({
    "exceptDomains": null,
    "hidden": false,
    "id": "url1658371411",
    "name": "stackOverflowUrl",
    "onlyDomains": null,
    "presentable": false,
    "required": false,
    "system": false,
    "type": "url"
  }))

  return app.save(collection)
}, (app) => {
  const collection = app.findCollectionByNameOrId("pbc_268752357")

  // remove field
  collection.fields.removeById("json1464297386")

  // remove field
  collection.fields.removeById("text843438578")

  // remove field
  collection.fields.removeById("url1658371411")

  return app.save(collection)
})
