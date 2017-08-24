---
title: Idiomatic Redux store updates
author: \@tlvince
date: 2017-08-18
---

# Rationale

## Update store slice

<div class="notes">
* Normalised Redux state
* Treat store as a DB
* Each data type gets its own slice (e.g. table)
* Slice records indexed by ID

What do you do when you need to update a record?
</div>

---

```js
const updateShipmentReducer = (state, action) => {
  const parentDocId = action.shipment.parentDocId
  const { [parentDocId]: omit, ...nextState } = state
  return {
    ...nextState,
    [action.shipment.snapshotId]: {
      ...action.shipment
    }
  }
}
```

<div class="notes">
* One example
* Shipments "table"
* Unfamiliar syntax

Lets break it down
</div>

# Computed properties

---

```js
const { [parentDocId]: ... }
```

<div class="notes">
* Bracket notation
* Probably familiar as accessor
* But not as a object property?
</div>

## ES2015 [computed property names][]

AKA dynamic object keys

```js
const parentDocId = 'foo'
const obj = {
  [parentDocId + 'Bar']: 'baz'
}
obj
//=> { fooBar: 'baz' }
```

<div class="notes">
* Use result of expression as object key
* Concatenated right within the object literal
</div>

[computed property names]: https://developer.mozilla.org/en/docs/Web/JavaScript/Reference/Operators/Object_initializer#Computed_property_names

# Object destructuring

---

```js
const { [parentDocId], ... } = state
```

<div class="notes">
* Looking at the `=` after the object
</div>

## ES2015 [object destructuring][]

Assigns new variables from object properties

```js
const props = { id: '1', name: 'bahmutov' }
const { id, name } = props
//=> const id = '1'; const name = 'bahmutov'
```

<div class="notes">
* Unpack properties from object into variables
</div>

[Object destructuring]: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Destructuring_assignment#Object_destructuring

# Object rest/spread

---

```js
const { ...nextState } = state
```

## [Object spread][]

Shallow-clones objects via:

```js
const nextState = Object.assign({}, state)
```

Not yet formalised in ES spec!

[Object spread]: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Spread_operator#Spread_in_object_literals

# Recap

---

```js
const updateShipmentReducer = (state, action) => {
  const parentDocId = action.shipment.parentDocId
  const { [parentDocId]: omit, ...nextState } = state
  return {
    ...nextState,
    [action.shipment.snapshotId]: {
      ...action.shipment
    }
  }
}
```

## Why?

* shipments indexed by ID in `shipments` slice
    * see: normalising state shape
* shipment has just been modified
    * e.g. `api.saveChanges` to update batch quantities
* Need to update store slice immutably

## Result

`state` was updated immutably with the parent shipment key omitted

```js
const state = { shipmentA: {}, shipmentB: {} }
const parentDocId = 'shipmentA'
const { [parentDocId]: omit, ...nextState } = state
nextState
//=> { shipmentB: {}}
```

Check with [Babel REPL][]

[Babel REPL]: https://babeljs.io/repl/#?babili=false&evaluate=true&lineWrap=false&presets=es2015%2Ces2015-loose%2Creact%2Cstage-0&targets=&browsers=&builtIns=false&debug=false&code_lz=MYewdgzgLgBADgQwE4FMxQCImASQCYwC8MA5BABYCWcAtmlAIIkBQzoks0CUKRMA3sxgwK1OugYAuAUOExKeaSQQthAXwA0s0bXoAhaYLnzFpAEaqYm7VV3oAwodnCFS4JbXNPbcNAEwAbURUdCxcPABdaRAaSigNGAA6ZLAUAA8oAGUobl41Pi4eVnYIEAAbFESykABzAAoSYPow_BgAWgA-UgSm0Ox8AEofSHLK6vqSGLj2rpIEqaghktGq2obUjOzcme6YDaycngGgA&experimental=true&loose=true&spec=false

## Actual update

```js
const parentDocId = action.shipment.parentDocId
return {
  // Spread
  ...nextState,
  [action.shipment.snapshotId]: {
    // Spread
    ...action.shipment
  }
}
```

# Fin!

## References

* [Use ES7 Object Rest Operator to Omit Properties][]
* [Airbnb JS style guide][]
* [Redux normalise state shape][]
* [Redux immutable update patterns][]
* [CRA supported language features and polyfills][]

[Airbnb JS style guide]: https://github.com/airbnb/javascript/blob/master/README.md#objects--rest-spread
[Redux normalise state shape]: http://redux.js.org/docs/recipes/reducers/NormalizingStateShape.html
[Redux immutable update patterns]: http://redux.js.org/docs/recipes/reducers/ImmutableUpdatePatterns.html
[Use ES7 Object Rest Operator to Omit Properties]: https://medium.com/@markbrouch/use-es2015-object-rest-operator-to-omit-properties-38a3ecffe90
[CRA supported language features and polyfills]: https://github.com/facebookincubator/create-react-app/blob/master/packages/react-scripts/template/README.md#supported-language-features-and-polyfills
