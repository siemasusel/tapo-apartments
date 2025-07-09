# ApartmentAvialabilityResponse

## Properties

Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**Slug** | **string** | Apartment slug | 
**ExternalUnavailableDates** | [**[]UnavailableDateRange**](UnavailableDateRange.md) | List of external unavailable date ranges | 
**InternalUnavailableDates** | [**[]UnavailableDateRange**](UnavailableDateRange.md) | List of internal unavailable date ranges | 
**ExternalLastSyncedAt** | **time.Time** | Date of the last sync with external system | 

## Methods

### NewApartmentAvialabilityResponse

`func NewApartmentAvialabilityResponse(slug string, externalUnavailableDates []UnavailableDateRange, internalUnavailableDates []UnavailableDateRange, externalLastSyncedAt time.Time, ) *ApartmentAvialabilityResponse`

NewApartmentAvialabilityResponse instantiates a new ApartmentAvialabilityResponse object
This constructor will assign default values to properties that have it defined,
and makes sure properties required by API are set, but the set of arguments
will change when the set of required properties is changed

### NewApartmentAvialabilityResponseWithDefaults

`func NewApartmentAvialabilityResponseWithDefaults() *ApartmentAvialabilityResponse`

NewApartmentAvialabilityResponseWithDefaults instantiates a new ApartmentAvialabilityResponse object
This constructor will only assign default values to properties that have it defined,
but it doesn't guarantee that properties required by API are set

### GetSlug

`func (o *ApartmentAvialabilityResponse) GetSlug() string`

GetSlug returns the Slug field if non-nil, zero value otherwise.

### GetSlugOk

`func (o *ApartmentAvialabilityResponse) GetSlugOk() (*string, bool)`

GetSlugOk returns a tuple with the Slug field if it's non-nil, zero value otherwise
and a boolean to check if the value has been set.

### SetSlug

`func (o *ApartmentAvialabilityResponse) SetSlug(v string)`

SetSlug sets Slug field to given value.


### GetExternalUnavailableDates

`func (o *ApartmentAvialabilityResponse) GetExternalUnavailableDates() []UnavailableDateRange`

GetExternalUnavailableDates returns the ExternalUnavailableDates field if non-nil, zero value otherwise.

### GetExternalUnavailableDatesOk

`func (o *ApartmentAvialabilityResponse) GetExternalUnavailableDatesOk() (*[]UnavailableDateRange, bool)`

GetExternalUnavailableDatesOk returns a tuple with the ExternalUnavailableDates field if it's non-nil, zero value otherwise
and a boolean to check if the value has been set.

### SetExternalUnavailableDates

`func (o *ApartmentAvialabilityResponse) SetExternalUnavailableDates(v []UnavailableDateRange)`

SetExternalUnavailableDates sets ExternalUnavailableDates field to given value.


### GetInternalUnavailableDates

`func (o *ApartmentAvialabilityResponse) GetInternalUnavailableDates() []UnavailableDateRange`

GetInternalUnavailableDates returns the InternalUnavailableDates field if non-nil, zero value otherwise.

### GetInternalUnavailableDatesOk

`func (o *ApartmentAvialabilityResponse) GetInternalUnavailableDatesOk() (*[]UnavailableDateRange, bool)`

GetInternalUnavailableDatesOk returns a tuple with the InternalUnavailableDates field if it's non-nil, zero value otherwise
and a boolean to check if the value has been set.

### SetInternalUnavailableDates

`func (o *ApartmentAvialabilityResponse) SetInternalUnavailableDates(v []UnavailableDateRange)`

SetInternalUnavailableDates sets InternalUnavailableDates field to given value.


### GetExternalLastSyncedAt

`func (o *ApartmentAvialabilityResponse) GetExternalLastSyncedAt() time.Time`

GetExternalLastSyncedAt returns the ExternalLastSyncedAt field if non-nil, zero value otherwise.

### GetExternalLastSyncedAtOk

`func (o *ApartmentAvialabilityResponse) GetExternalLastSyncedAtOk() (*time.Time, bool)`

GetExternalLastSyncedAtOk returns a tuple with the ExternalLastSyncedAt field if it's non-nil, zero value otherwise
and a boolean to check if the value has been set.

### SetExternalLastSyncedAt

`func (o *ApartmentAvialabilityResponse) SetExternalLastSyncedAt(v time.Time)`

SetExternalLastSyncedAt sets ExternalLastSyncedAt field to given value.



[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


