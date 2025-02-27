/*
Represents a shortcut:

* **bypassFocused** - whether or not trigger the action if something is in focus
* **condition** - the function that evaluates if the action should be called
* **action** - the function to execute when the shortcut is pressed
* **shortcut** - the array of **keyCodes** that needs to be matched
*/
type Provider.Shortcuts.Shortcut {
  action : Function(Promise(Void)),
  condition : Function(Bool),
  shortcut : Array(Number),
  bypassFocused : Bool
}

/* Record for `Provider.Shortcuts`. */
type Provider.Shortcuts {
  shortcuts : Array(Provider.Shortcuts.Shortcut)
}

/*
This provider allows components to subscribe to global shortcuts.

```
component Main {
  use Provider.Shortcuts {
    shortcuts:
      [
        {
          action: () { Window.alert("Shotcut pressed!") },
          shortcut: [Html.Event.CTRL, Html.Event.G],
          condition: () { true },
          bypassFocused: false
        }
      ]
  }

  fun render : Html {
    <div>"Press CTRL+G"</div>
  }
}
```
*/
provider Provider.Shortcuts : Provider.Shortcuts {
  /* The listener unsubscribe function. */
  state listener : Maybe(Function(Void)) = Maybe.Nothing

  /* Handles keypress events. */
  fun handle (event : Html.Event) : Array(Array(Promise(Void))) {
    let control =
      if event.ctrlKey && event.keyCode != 17 {
        Maybe.Just(17)
      }

    let shift =
      if event.shiftKey && event.keyCode != 16 {
        Maybe.Just(16)
      }

    let combo =
      [Maybe.Just(event.keyCode), control, shift]
      |> Array.compact()
      |> Array.sortBy((item : Number) { item })

    let focused =
      `document.querySelector("*:focus")`

    for subscription of subscriptions {
      for item of subscription.shortcuts {
        Html.Event.stopPropagation(event)
        Html.Event.preventDefault(event)
        item.action()
      } when {
        let sorted =
          item.shortcut
          |> Array.sortBy((item : Number) : Number { item })

        (sorted == combo && item.condition()) && (!focused || item.bypassFocused)
      }
    }
  }

  /* Updates the provider. */
  fun update : Promise(Void) {
    if Array.isEmpty(subscriptions) {
      Maybe.map(listener, (unsubscribe : Function(Void)) { unsubscribe() })
      next { listener: Maybe.Nothing }
    } else {
      if listener == Maybe.Nothing {
        next {
          listener: Maybe.Just(Window.addEventListener("keydown", true, handle))
        }
      }
    }
  }
}
