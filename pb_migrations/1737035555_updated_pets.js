/// <reference path="../pb_data/types.d.ts" />
migrate((app) => {
  const collection = app.findCollectionByNameOrId("pbc_1820489269")

  // update collection data
  unmarshal({
    "name": "patients"
  }, collection)

  return app.save(collection)
}, (app) => {
  const collection = app.findCollectionByNameOrId("pbc_1820489269")

  // update collection data
  unmarshal({
    "name": "pets"
  }, collection)

  return app.save(collection)
})
