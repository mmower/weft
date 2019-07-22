#  Weft

* Version 0.9 22/07/2019

Weft is a framework designed to allow a Cocoa application to dynamically create, and interactive with, a user interface built  at runtime from a source definition. Weft is a component of **Project Mentat**.

The Weft framework includes a `WeftRunner` class that accepts a UI definition in the Weft `XML` format and returns a functioning `NSWindow` and `NSWindowController`. The user is able to interact with the controls in the UI. When the user dismisses the UI the host application can query for the value of elements such as text fields and checkboxes.

A Weft interface is specified using an XML based syntax that maps 1:1 to UI elements as described in the Element Guide below.

## Acknowledgements

Weft was partially inspired by [Pashua](https://www.bluem.net/en/projects/pashua/) and [Cocoa Dialog](https://cocoadialog.com/) although they do not share any code in common. Further their uses cases are different in that Weft is intended to be embedded into a Cocoa application and to interact with it.
 
## Example

    <window title='Weft Test Window' width='640' height='120'>
      <col insets='20,20,20,20'>
        <row insets='10,10,10,10'>
          <label width='65' title='Name:'/>
          <textfield id='name' placeholder='John. Q. Public'/>
        </row>
        <row insets='10,10,10,10'>
          <label width='65' title='Password:'/>
          <password id='password'/>
        </row>
        <row insets='10,10,10,10'>
          <checkbox title='Remember Me' id='remember'/>
          <popupbutton id='length' choices='1 week,2 weeks,1 month' default='2 weeks'/>
          <ok/>
        </row>
      </col>
    </window>


## Element Guide

### <window>

A `<window>` element specifies the top-level window and contains all other elements.

    <window>…</window>
    
#### Attributes
    * title: Title for the window
    * width: initial width of the window (this may be changed if the layout ends up wider)
    * height: initial height of the window (this may be changed if the layout ends up taller)
    
### <row>

A `<row>` organises its contents horizontally. Internally a row is represented via an `NSStackView` whose `orientation` property is set to `NSUserInterfaceLayoutOrientationHorizontal`.

#### Attributes
  * `insets` - a series of values used as a margin between the edge of the row and its contents. Specified as `top`, `left`, `bottom`, `right`
  * `distribution` - controls how contents are distributed across the width of the row. Valid values are `equalcentering`, `equalspacing`, `fill`, `fillequally`, `fillproportionally`, `gravity`

### <col>

A `<col>` organises its contents vertically. Internally a col is represented via an `NSStackView` whose `orientation` property is set to `NSUserInterfaceLayoutOrientationVertical`.

#### Attributes

A col organises its contents as a vertical stack of elements.

### <textfield>

A `<textfield>` creates an `NSTextField`  that supports a single line of editable text.

#### Attributes
* `id`: a unique identifier for the textfield that can be used later to retrieve its value
* `default`: default value to user for the textfield
* `placeholder`: value to be displayed in textfield if there is no value
* `tooltip`:  value to be displayed as a tooltip
* `disabled`: set to `1` to disable this control

### <textbox>

A `<textbox>` creates an `NSTextView` that supports editing a longer text.

#### Attributes

### <password>

A `<password>` creates an `NSSecureTextField` that allows for editing sensitive values such as passwords and prevents them appearing on screen.

#### Attributes

### <button>

A `<button>` element specifies a push-button (`NSButton`) control. 

#### Attributes
* `id`: unique identifier for the button. Will be sent to the delegate.

### <ok>

An `<ok>` element specifies an **Ok** button. It is a special type of button that, when pushed, sends the `WeftApplicationDelegate` a message `- (void)weftApplication:(WeftApplication *)app complete:(BOOL)ok` passing `YES` as the `complete` value.

#### Attributes
* `title`: the title to appear on the ok button

### <cancel>

A `<cancel>` element specifies a **Cancel** button. It is a special type of button that, when pushed, sends the `WeftApplicationDelegate` a message `- (void)weftApplication:(WeftApplication *)app complete:(BOOL)ok` passing `NO` as the `complete` value.

### <checkbox>

#### Attributes

### <radio>

#### Attributes

### <popupbutton>

#### Attributes

### <datepicker>

#### Attributes

