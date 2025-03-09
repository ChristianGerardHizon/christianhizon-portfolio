/// <reference path="../pb_data/types.d.ts" />
migrate((app) => {
  const collection = app.findCollectionByNameOrId("pbc_2888295135")

  // update collection data
  unmarshal({
    "name": "medical_records"
  }, collection)

  return app.save(collection)
}, (app) => {
  const collection = app.findCollectionByNameOrId("pbc_2888295135")

  // update collection data
  unmarshal({
    "name": "record"
  }, collection)

  return app.save(collection)
})
