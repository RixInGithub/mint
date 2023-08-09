/* Functions for decoding specific types from an `Object`. */
module Object.Decode {
  /*
  Decodes the object as an `Array` using the given decoder.

    Object.Decode.array(`["A", "B"]`, Object.Decode.string) == Result::Ok(["a", "b"])
  */
  fun array (
    input : Object,
    decoder : Function(Object, Result(Object.Error, a))
  ) : Result(Object.Error, Array(a)) {
    `Decoder.array(#{decoder})(#{input})`
  }

  /*
  Decodes the object as a `Bool`

    Object.Decode.boolean(`true`) == Result::Ok(true)
  */
  fun boolean (input : Object) : Result(Object.Error, Bool) {
    `Decoder.boolean(#{input})`
  }

  /*
  Decodes a field from an object using the given decoder.

    Object.Decode.field(
      `{field: "Value"}`, "field", Object.Decode.string) == Result::Ok("Value")
  */
  fun field (
    input : Object,
    key : String,
    decoder : Function(Object, Result(Object.Error, a))
  ) : Result(Object.Error, a) {
    `Decoder.field(#{key}, #{decoder})(#{input})`
  }

  /*
  Decodes the object as a `Maybe(a)` using the given decoder.

    Object.Decode.maybe(`"A"`, Object.Decode.String) == Result::Ok(Maybe::Just("A"))
    Object.Decode.maybe(`null`, Object.Decode.String) == Result::Ok(Maybe::Nothing)
  */
  fun maybe (
    input : Object,
    decoder : Function(Object, Result(Object.Error, a))
  ) : Result(Object.Error, Maybe(a)) {
    `Decoder.maybe(#{decoder})(#{input})`
  }

  /*
  Decodes the object as a `Number`

    Object.Decode.number(`0`) == Result::Ok(0)
  */
  fun number (input : Object) : Result(Object.Error, Number) {
    `Decoder.number(#{input})`
  }

  /*
  Decodes the object as a `String`

    Object.Decode.string(`"A"`) == Result::Ok("A")
  */
  fun string (input : Object) : Result(Object.Error, String) {
    `Decoder.string(#{input})`
  }

  /*
  Decodes the object as a `Time`

    Object.Decode.time(`"new Date()"`)
  */
  fun time (input : Object) : Result(Object.Error, Time) {
    `Decoder.time(#{input})`
  }
}
