# UnavailableDateRange

## Properties

Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**StartDate** | **string** | Start date of the unavailable period | 
**EndDate** | **string** | End date of the unavailable period | 
**Source** | **string** | Source of the unavailable dates (e.g., \&quot;website\&quot;, \&quot;bookingcom\&quot;) | 

## Methods

### NewUnavailableDateRange

`func NewUnavailableDateRange(startDate string, endDate string, source string, ) *UnavailableDateRange`

NewUnavailableDateRange instantiates a new UnavailableDateRange object
This constructor will assign default values to properties that have it defined,
and makes sure properties required by API are set, but the set of arguments
will change when the set of required properties is changed

### NewUnavailableDateRangeWithDefaults

`func NewUnavailableDateRangeWithDefaults() *UnavailableDateRange`

NewUnavailableDateRangeWithDefaults instantiates a new UnavailableDateRange object
This constructor will only assign default values to properties that have it defined,
but it doesn't guarantee that properties required by API are set

### GetStartDate

`func (o *UnavailableDateRange) GetStartDate() string`

GetStartDate returns the StartDate field if non-nil, zero value otherwise.

### GetStartDateOk

`func (o *UnavailableDateRange) GetStartDateOk() (*string, bool)`

GetStartDateOk returns a tuple with the StartDate field if it's non-nil, zero value otherwise
and a boolean to check if the value has been set.

### SetStartDate

`func (o *UnavailableDateRange) SetStartDate(v string)`

SetStartDate sets StartDate field to given value.


### GetEndDate

`func (o *UnavailableDateRange) GetEndDate() string`

GetEndDate returns the EndDate field if non-nil, zero value otherwise.

### GetEndDateOk

`func (o *UnavailableDateRange) GetEndDateOk() (*string, bool)`

GetEndDateOk returns a tuple with the EndDate field if it's non-nil, zero value otherwise
and a boolean to check if the value has been set.

### SetEndDate

`func (o *UnavailableDateRange) SetEndDate(v string)`

SetEndDate sets EndDate field to given value.


### GetSource

`func (o *UnavailableDateRange) GetSource() string`

GetSource returns the Source field if non-nil, zero value otherwise.

### GetSourceOk

`func (o *UnavailableDateRange) GetSourceOk() (*string, bool)`

GetSourceOk returns a tuple with the Source field if it's non-nil, zero value otherwise
and a boolean to check if the value has been set.

### SetSource

`func (o *UnavailableDateRange) SetSource(v string)`

SetSource sets Source field to given value.



[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


