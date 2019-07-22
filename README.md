#  Weft

* Version 0.1 17/07/2019

Weft is a framework designed to allow a Cocoa application to dynamically create interactive user interfaces at runtime. It uses an XML based syntax. In this it has things in common with things like Pashua and Cocoa Dialog (although the use case for those tools is different) and syntactically will not be a mile from things like XUL and XAML although simpler and more limited in application.

Weft is part of Project Mentat.

That Weft allows automatic layout is down to using NSStackView.

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

    <window>…</window>
    
#### Attributes
    * title: Title for the window
    * width: initial width of the window (this may be changed if the layout ends up wider)
    * height: initial height of the window (this may be changed if the layout ends up taller)
    
### <row>

A row organises its contents horizontally. Internally a row is represented via an `NSStackView` whose `orientation` property is set to `NSUserInterfaceLayoutOrientationHorizontal`.

#### Attributes
  * `insets` - a series of values used as a margin between the edge of the row and its contents. Specified as `top`, `left`, `bottom`, `right`
  * `distribution` - controls how contents are distributed across the width of the row. Valid values are `equalcentering`, `equalspacing`, `fill`, `fillequally`, `fillproportionally`, `gravity`

### <col>

A `col` organises its contents vertically. Internally a col is represented via an `NSStackView` whose `orientation` property is set to `NSUserInterfaceLayoutOrientationVertical`.

#### Attributes

A col organises its contents as a vertical stack of elements.

### <textfield>

#### Attributes

### <textbox>

#### Attributes

### <password>

#### Attributes

### <button>

#### Attributes

### <checkbox>

#### Attributes

### <radio>

#### Attributes

### <popupbutton>

#### Attributes

### <datepicker>


