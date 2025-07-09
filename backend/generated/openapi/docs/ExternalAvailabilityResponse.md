# ExternalAvailabilityResponse

## Properties

Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**Slug** | **string** | Apartment slug | 
**UnavailableDates** | [**[]UnavailableDateRange**](UnavailableDateRange.md) | List of unavailable date ranges from external source | 
**LastSyncedAt** | **time.Time** | Time of last successful sync | 
**Source** | **string** | Source of the external data | 

## Methods

### NewExternalAvailabilityResponse

`func NewExternalAvailabilityResponse(slug string, unavailableDates []UnavailableDateRange, lastSyncedAt time.Time, source string, ) *ExternalAvailabilityResponse`

NewExternalAvailabilityResponse instantiates a new ExternalAvailabilityResponse object
This constructor will assign default values to properties that have it defined,
and makes sure properties required by API are set, but the set of arguments
will change when the set of required properties is changed

### NewExternalAvailabilityResponseWithDefaults

`func NewExternalAvailabilityResponseWithDefaults() *ExternalAvailabilityResponse`

NewExternalAvailabilityResponseWithDefaults instantiates a new ExternalAvailabilityResponse object
This constructor will only assign default values to properties that have it defined,
but it doesn't guarantee that properties required by API are set

### GetSlug

`func (o *ExternalAvailabilityResponse) GetSlug() string`

GetSlug returns the Slug field if non-nil, zero value otherwise.

### GetSlugOk

`func (o *ExternalAvailabilityResponse) GetSlugOk() (*string, bool)`

GetSlugOk returns a tuple with the Slug field if it's non-nil, zero value otherwise
and a boolean to check if the value has been set.

### SetSlug

`func (o *ExternalAvailabilityResponse) SetSlug(v string)`

SetSlug sets Slug field to given value.


### GetUnavailableDates

`func (o *ExternalAvailabilityResponse) GetUnavailableDates() []UnavailableDateRange`

GetUnavailableDates returns the UnavailableDates field if non-nil, zero value otherwise.

### GetUnavailableDatesOk

`func (o *ExternalAvailabilityResponse) GetUnavailableDatesOk() (*[]UnavailableDateRange, bool)`

GetUnavailableDatesOk returns a tuple with the UnavailableDates field if it's non-nil, zero value otherwise
and a boolean to check if the value has been set.

### SetUnavailableDates

`func (o *ExternalAvailabilityResponse) SetUnavailableDates(v []UnavailableDateRange)`

SetUnavailableDates sets UnavailableDates field to given value.


### GetLastSyncedAt

`func (o *ExternalAvailabilityResponse) GetLastSyncedAt() time.Time`

GetLastSyncedAt returns the LastSyncedAt field if non-nil, zero value otherwise.

### GetLastSyncedAtOk

`func (o *ExternalAvailabilityResponse) GetLastSyncedAtOk() (*time.Time, bool)`

GetLastSyncedAtOk returns a tuple with the LastSyncedAt field if it's non-nil, zero value otherwise
and a boolean to check if the value has been set.

### SetLastSyncedAt

`func (o *ExternalAvailabilityResponse) SetLastSyncedAt(v time.Time)`

SetLastSyncedAt sets LastSyncedAt field to given value.


### GetSource

`func (o *ExternalAvailabilityResponse) GetSource() string`

GetSource returns the Source field if non-nil, zero value otherwise.

### GetSourceOk

`func (o *ExternalAvailabilityResponse) GetSourceOk() (*string, bool)`

GetSourceOk returns a tuple with the Source field if it's non-nil, zero value otherwise
and a boolean to check if the value has been set.

### SetSource

`func (o *ExternalAvailabilityResponse) SetSource(v string)`

SetSource sets Source field to given value.



[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


